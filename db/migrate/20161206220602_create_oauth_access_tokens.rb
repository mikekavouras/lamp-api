class CreateOauthAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :oauth_access_tokens do |t|
      t.string :token
      t.string :refresh_token
      t.datetime :expires_at, index: true
      t.datetime :revoked_at, index: true
      t.string :scopes
      t.integer :resource_owner_id, index: true
      t.integer :oauth_application_id

      t.timestamps
    end

    add_index :oauth_access_tokens, :token, unique: true
    add_index :oauth_access_tokens, :refresh_token, unique: true
  end
end
