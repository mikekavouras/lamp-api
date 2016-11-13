class PagesController < ApplicationController
  def ping
    render text: "pong"
  end

  def purple
    GlowWorker.perform_async(Device.first.id, 'purple')
  end
end
