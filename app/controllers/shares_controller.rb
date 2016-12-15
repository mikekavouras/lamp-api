class SharesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :require_share

  helper_method :share

  layout false

  def show
  end

  def create
    share.interact

    redirect_to share.url
  end

  private

  def token
    "#{params[:token]}"
  end

  def share
    @share ||= Share.find_by_token(token)
  end

  def require_share
    raise(ActiveRecord::RecordNotFound) unless share.present?
  end
end
