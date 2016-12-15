class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def ping
    render plain: "pong"
  end

  def glow
    GlowWorker.perform_async(Device.first.id, params[:color])

    render plain: "glow"
  end
end
