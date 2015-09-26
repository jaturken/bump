class PushSender
  include Sidekiq::Worker
  HOST = "https://android.googleapis.com/gcm/send"

  sidekiq_options :queue => :push

  def perform(bump_id, cobump_id)
    bumps = Bump.eager(:socials).where(id: [bump_id, cobump_id])
    bump = bumps.find{ |b| b.id == bump_id}
    cobump = bumps.find{ |b| b.id == cobump_id}

    send_push(bump, cobump)
    send_push(cobump, bump)
  end

  def send_push(bump, cobump)
    socials = cobump.socials.map do |social|
      {
        name: social.name,
        token: social.token,
        profile_url: social.profile_url
      }
    end.compact.to_s
    data = {
      data: {
        bump: {
          socials: socials, event_id: bump.event_id
        }
      },
      to: bump.push_token
    }
    c = Curl::Easy.http_post(HOST, data.to_json) do |curl|
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Authorization'] = 'key=AIzaSyCg-U8doNpny9_Uz89kqxqP-eRGzfa3nm0'
      curl.verbose = true
    end
  end
end
