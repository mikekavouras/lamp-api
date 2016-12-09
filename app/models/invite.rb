class Invite < ApplicationRecord
  belongs_to :user, optional: true

  def token
    hashids = Hashids.new(Rails.application.secrets.hashids_salt, 6)
    hashids.encode(self.id)
  end
end
