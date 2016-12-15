class User < ApplicationRecord
  has_many :user_devices
  has_many :devices, through: :user_devices
  has_many :photos
  has_many :apns_tokens
  has_many :invites
  has_many :interactions
  has_many :events
  has_many :shares
  has_many :oauth_access_tokens, foreign_key: :resource_owner_id
end
