class Invite < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :device

  scope :active, -> { where('expires_at > ? AND revoked_at IS NULL AND (usage_limit IS NULL OR usage_limit = 0 OR usage_limit > usage_count)', Time.now) }

  def self.find_by_token(token)
    record = begin
      hashids = Hashids.new(Rails.application.secrets.hashids_salt, 6)
      id = hashids.decode(token)[0]
      return self.active.where(id: id).first if id
    rescue Hashids::InputError
      nil
    end
  end

  def token
    hashids = Hashids.new(Rails.application.secrets.hashids_salt, 6)
    hashids.encode(self.id)
  end

  def accept
    self.usage_count += 1
    self.save
  end
end
