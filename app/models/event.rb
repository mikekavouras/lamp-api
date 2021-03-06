class Event < ApplicationRecord
  belongs_to :user
  belongs_to :interaction

  validates :user, presence: true
  validates :interaction, presence: true

  before_validation :set_status

  # TODO, should this move into the interaction?, the worker?
  def perform
    begin
      color = ("%02x%02x%02x" % [interaction.red, interaction.green, interaction.blue]).upcase

      if device_response = device.glow(color)
        self.response = device_response.to_json
        self.status = "success"
      else
        self.status = "error"
      end
    rescue Exception => e
      self.error = e.message
      self.status = "error"
    end

    save
  end

  private

  def device
    interaction.user_device.device
  end

  def set_status
    self.status ||= "pending"
  end
end
