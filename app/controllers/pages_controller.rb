class PagesController < ApplicationController
  def ping
    render text: "pong"
  end
end
