class PushSender
  include Sidekiq::Worker
  sidekiq_options :queue => :push

   def perform(bump_id, cobump_id)
      bumps = Bump.eager(:socials).where(id: [bump_id, cobump_id])
      bump = bumps.find{ |b| b.id == bump_id}
      cobump = bumps.find{ |b| b.id == bump_id}

      send_push(bump, cobump)
      send_push(bump, cobump)
   end

   def send_push(bump, cobump)
    socials = cobump.socials.map do |social|
        {
          name: social.name,
          token: social.token,
          profile_url: social.profile_url
        }
      end.compact
      GCM.send_notification( [bump.push_token], {data: socials }.to_json )
   end
end
