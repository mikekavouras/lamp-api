Device.where(
  particle_id: ENV['PARTICLE_DEVICE_ID'],
  uid: "52f8a199ed929bf331b7a81a47b13f3347dc798c5d03ba4701e449d177810158"
).first_or_create
OauthApplication.where(name: "iOS App", redirect_uri: "https://lamp.engineering").first_or_create
