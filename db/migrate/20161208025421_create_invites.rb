class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :checkout_id, index: true
      t.integer :user_id, index: true
      t.integer :device_id, index: true
      t.integer :usage_count, default: 0, index: true
      t.integer :usage_limit, index: true
      t.datetime :expires_at, index: true
      t.datetime :revoked_at, index: true

      t.timestamps null: false, index: true
    end

  end
end
