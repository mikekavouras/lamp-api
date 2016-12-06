class OauthApplication < ApplicationRecord
  has_many :oauth_access_tokens

  before_validation :set_uid
  before_validation :set_secret

  validates :name, presence: true
  validates :redirect_uri, presence: true
  validates :uid, presence: true
  validates :secret, presence: true

  private

  def set_uid
    self.uid ||= SecureRandom.hex(32)
  end

  def set_secret
    self.secret ||= SecureRandom.hex(32)
  end
end
