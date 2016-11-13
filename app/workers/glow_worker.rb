class GlowWorker
  include Sidekiq::Worker

  def perform(device_id, color = 'red')
    device = Device.find(device_id)
    device.glow(color)
  end
end
