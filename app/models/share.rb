class Share < ApplicationRecord
  belongs_to :user
  belongs_to :interaction

  validates :user, presence: true
  validates :interaction, presence: true

  scope :active, -> { where('(expires_at IS NULL OR expires_at > ?) AND (usage_limit IS NULL OR usage_limit = 0 OR usage_limit > usage_count)', Time.now) }

  def self.find_by_token(token)
    record = begin
      hashids = Hashids.new(Rails.application.secrets.share_hashids_salt, 16)
      id = hashids.decode(token)[0]
      return self.active.where(id: id).first if id
    rescue Hashids::InputError
      nil
    end
  end

  def token
    hashids = Hashids.new(Rails.application.secrets.share_hashids_salt, 16)
    hashids.encode(self.id)
  end

  def url
    "#{Rails.application.secrets.domain}/shares/#{self.token}"
  end

  def interact
    ActiveRecord::Base.transaction do
      self.usage_count += 1
      self.save
      event = interaction.events.create(user: user)
      EventWorker.perform_async(event.id)
    end
  end
end
