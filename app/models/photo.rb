class Photo < ApplicationRecord
  belongs_to :user

  has_many :relationships
end
