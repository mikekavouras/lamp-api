class OauthController < ApplicationController
  before_action :require_oauth_application
  before_action :require_oauth_access_token, only: [:refresh, :revoke]

  def create
    @current_user = User.create(anonymous: true)
    @oauth_access_token = oauth_application.oauth_access_tokens.create(resource_owner_id: current_user.id, scopes: 'all')
    render json: {
      access_token: oauth_access_token.token,
      refresh_token: oauth_access_token.refresh_token,
      token_type: "bearer",
      expires_in: oauth_access_token.expires_at - Time.now
    }
  end

  def refresh
    oauth_access_token.revoke
    @oauth_access_token = oauth_application.oauth_access_tokens.create(resource_owner_id: current_user.id, scopes: 'all')
    render json: {
      access_token: oauth_access_token.token,
      refresh_token: oauth_access_token.refresh_token,
      token_type: "bearer",
      expires_in: oauth_access_token.expires_at - Time.now
    }
  end

  # OAuth 2.0 Token Revocation - http://tools.ietf.org/html/rfc7009
  def revoke
    oauth_access_token.revoke
    head :ok
  end
end
