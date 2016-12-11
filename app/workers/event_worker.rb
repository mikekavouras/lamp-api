class EventWorker
  include Sidekiq::Worker

  def perform(event_id)
    event = Event.includes(interaction: { user_device: :device }).find(event_id)
    event.perform
  end
end
