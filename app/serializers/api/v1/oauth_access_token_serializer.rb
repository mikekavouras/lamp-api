module Api
  module V1
    class OauthAccessTokenSerializer < ActiveModel::Serializer
      attributes \
        :access_token,
        :refresh_token,
        :expires_in,
        :token_type

      def access_token
        object.token
      end

      def expires_in
        object.expires_at - Time.now
      end

      def token_type
        "bearer"
      end
    end
  end
end
