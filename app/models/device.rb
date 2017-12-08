class Device < ApplicationRecord
  COLORS = ['red', 'green', 'blue', 'purple'].freeze

  has_many :user_devices
  has_many :users, through: :user_devices

  validates :particle_id, presence: true, uniqueness: true

  before_save :downcase_particle_id

  def glow(color)
    if COLORS.include?(color)
      particle_device.function('glow', color)
    else
      particle_device.function('rgb', color)
    end
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

  def name
    parsed_params[:name]
  end

  private

  def parsed_params
    @parsed_params ||= JSON.parse(params).with_indifferent_access rescue {}
  end

  def downcase_particle_id
    self.particle_id = particle_id.downcase
  end
end
