class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :user_device
  belongs_to :photo, optional: true

  has_many :events

  validates :user, presence: true
  validates :user_device, presence: true
end
