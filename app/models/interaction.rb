class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :device
  belongs_to :photo, optional: true

  validates :user, presence: true
  validates :device, presence: true
end
