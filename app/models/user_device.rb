class UserDevice < ApplicationRecord
  belongs_to :user
  belongs_to :device
  belongs_to :invite

  validates :user, presence: true
  validates :device, presence: true
end
