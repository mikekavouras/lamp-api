class OauthAccessToken < ApplicationRecord
  belongs_to :oauth_application
  belongs_to :resource_owner, class_name: 'User'

  before_validation :set_token
  before_validation :set_refresh_token

  validates :oauth_application, presence: true
  validates :resource_owner, presence: true
  validates :token, presence: true
  validates :refresh_token, presence: true

  def expired?
    expires_at.present? && expires_at < Time.now
  end

  def revoked?
    revoked_at.present?
  end

  def revoke
    self.update_attribute(:revoked_at, Time.now)
  end

  private

  def set_token
    self.token ||= SecureRandom.hex(32)
  end

  def set_refresh_token
    self.refresh_token ||= SecureRandom.hex(32)
  end
end
