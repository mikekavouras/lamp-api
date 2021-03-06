module Api
  module V1
    class ApiController < ActionController::API
      include OauthHelper

      before_action :require_oauth_application
      before_action :require_oauth_access_token
    end
  end
end
