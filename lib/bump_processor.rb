require 'json'

class BumpProcessor

  attr_accessor :data
  attr_accessor :bump

  def self.process_request(request)
    self.new(request).process
  end

  def initialize(request)
    @data = JSON.parse(request.env['rack.input'].read)
  end

  def process
    save_bump
    save_socials
    search_cobump
  end

  def save_bump
    longtitude, latitude = data['loc'].split(';')
    bump_data = {
      event_id: data['event_id'],
      time: data['time'],
      push_token: data['push_token'],
      generate_code: data['generate_code'],
      latitude: latitude,
      longtitude: longtitude
    }
    @bump = Bump.create(bump_data)
  end

  def save_socials
    DB.transaction do
      data['socials'].map do |social|
        social_data = {
          bump_id: bump.id,
          name: social['name'],
          token: social['token'],
          profile_url: social['profile_url']
        }
        Social.create(social_data)
      end
    end
  end

  def search_cobump
    # TODO: send signal to worker to start searching cobump
  end
end
