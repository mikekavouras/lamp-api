module Api
  module V1
    class OauthController < ApiController
      skip_before_action :require_oauth_access_token, only: [:create]

      def create
        @current_user = User.create(anonymous: true)
        @oauth_access_token = oauth_application.oauth_access_tokens.create(resource_owner_id: current_user.id, scopes: 'all')
        render json: @oauth_access_token
      end

      def refresh
        oauth_access_token.revoke
        @oauth_access_token = oauth_application.oauth_access_tokens.create(resource_owner_id: current_user.id, scopes: 'all')
        render json: @oauth_access_token
      end

      # OAuth 2.0 Token Revocation - http://tools.ietf.org/html/rfc7009
      def revoke
        oauth_access_token.revoke
        head :ok
      end
    end
  end
end
