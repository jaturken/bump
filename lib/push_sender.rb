class PushSender
  include Sidekiq::Worker
  sidekiq_options :queue => :push


   def perform(bump_id, cobump_id)
      # TODO: send notifications
   end
end
