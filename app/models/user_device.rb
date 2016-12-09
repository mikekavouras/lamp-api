class UserDevice < ApplicationRecord
  belongs_to :user
  belongs_to :device
  belongs_to :invite, optional: true

  validates :user, presence: true
  validates :device, presence: true
  validates :name, presence: true
end
