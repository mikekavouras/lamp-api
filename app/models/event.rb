class Event < ApplicationRecord
  belongs_to :user
  belongs_to :interaction

  validates :user, presence: true
  validates :interaction, presence: true

  before_validation :set_status

  # TODO, should this move into the interaction?, the worker?
  def perform
    begin
      color = if interaction.red == 255 && interaction.blue == 128
        'purple'
      elsif interaction.red == 255 && interaction.blue == 16
        'magenta'
      elsif interaction.green == 255 && interaction.blue == 255
        'cyan'
      elsif interaction.red > 0
        'red'
      elsif interaction.green > 0
        'green'
      elsif interaction.blue > 0
        'blue'
      end

      color ||= 'purple'

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
