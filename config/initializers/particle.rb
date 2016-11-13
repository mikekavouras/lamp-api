require 'particle'

Particle.configure do |c|
  c.access_token = Rails.application.secrets.particle_access_token
end
