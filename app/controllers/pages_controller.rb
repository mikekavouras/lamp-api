class PagesController < ApplicationController
  def ping
    render plain: "pong"
  end

  def purple
    GlowWorker.perform_async(Device.first.id, 'purple')

    render plain: "glow"
  end
end
