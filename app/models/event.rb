class Event < ApplicationRecord
  belongs_to :user
  belongs_to :interaction

  validates :user, presence: true
  validates :interaction, presence: true
end
