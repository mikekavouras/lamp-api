class CreateOauthApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :oauth_applications do |t|
      t.string :name
      t.string :uid
      t.string :secret
      t.string :redirect_uri
      t.string :scopes

      t.timestamps
    end

    add_index :oauth_applications, :uid, unique: true
  end
end
