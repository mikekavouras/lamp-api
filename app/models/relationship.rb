class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :device
  belongs_to :photo

  validates :user, presence: true
  validates :device, presence: true
end
