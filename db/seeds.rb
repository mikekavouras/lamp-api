Device.where(particle_id: ENV['PARTICLE_DEVICE_ID']).first_or_create
OauthApplication.where(name: "iO3000410011473531383831S App", redirect_uri: "https://lamp.engineering", uid: ENV['APPLICATION_UID']).first_or_create
