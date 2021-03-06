class CobumpFinder
  include Sidekiq::Worker
  sidekiq_options :queue => :cobump

  SECONDS = 10 # max time between bumps

  def perform(bump_id)
    bump = Bump[bump_id]
    cobump = find_cobump(bump)
    if cobump
      p "Cobump found"
      notify_devices(bump, cobump)
    else
      p 'Cobump not found'
    end
  end

  def find_cobump(bump)
    cobump_condition = <<-SQL
      SELECT * FROM bumps WHERE
      latitude = #{bump.latitude} AND longtitude = #{bump.longtitude} AND
      id != #{bump.id} AND
      (
        time > #{(bump.time - SECONDS * 1000)} OR
        created_at > '#{(bump.created_at - SECONDS).to_s[0..-6]}'
      )
    SQL
    Bump.fetch(cobump_condition).sort do |bump1, bump2|
      c1, c2 = bump1.created_at, bump2.created_at
      c1 == c2 ? bump1.time <=> bump2.time : c1 <=> c2
    end.first
  end

  def notify_devices(bump, cobump)
    PushSender.perform_async(bump.id, cobump.id)
  end
end
