class Device < ApplicationRecord
  COLORS = ['red', 'blue', 'purple'].freeze

  validates :particle_id, presence: true, uniqueness: true

  def glow(color)
    return false unless COLORS.include?(color)

    particle_device.function('glow', color)
  end

  def particle_device
    return @particle_device if defined?(@particle_device)
    client = Particle::Client.new
    @particle_device = client.device(particle_id)
  end

  def import(particle_device)
    self.params = particle_device.attributes.to_json
    self.save
  end
end
