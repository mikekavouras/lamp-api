device = Device.where(particle_id: ENV['PARTICLE_DEVICE_ID']).first_or_create
device.import
