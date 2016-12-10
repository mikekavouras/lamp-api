Device.where(particle_id: ENV['PARTICLE_DEVICE_ID']).first_or_create
OauthApplication.where(name: "iOS App", redirect_uri: "https://lamp.engineering").first_or_create
