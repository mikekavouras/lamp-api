module Api
  module V1
    module OauthHelper
      private

      def current_user
        return @current_user if defined?(@current_user)

        oauth_access_token.resource_owner
      end

      def oauth_application_id
        request.headers["HTTP_X_APPLICATION_ID"]
      end

      def oauth_authorization_header
        request.headers["HTTP_AUTHORIZATION"]
      end

      def oauth_bearer_token
        oauth_authorization_header.match(/Bearer\s*(.*)/)[1] rescue nil
      end

      def oauth_application
        return @oauth_application if defined?(@oauth_application)
        return nil if oauth_application_id.blank?

        @oauth_application = OauthApplication.where(uid: oauth_application_id).first
      end

      def oauth_access_token
        return @oauth_access_token if defined?(@oauth_access_token)
        return nil if oauth_bearer_token.blank?

        @oauth_access_token = oauth_application.oauth_access_tokens.where(token: oauth_bearer_token).first
      end

      def require_oauth_application
        render plain: "invalid_request", status: 400 unless oauth_application
      end

      def require_oauth_access_token
        render plain: "invalid_grant", status: 400 if oauth_access_token.blank? || oauth_access_token.revoked? || oauth_access_token.expired?
      end
    end
  end
end
