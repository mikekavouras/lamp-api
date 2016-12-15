class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.integer :user_id, index: true
      t.integer :interaction_id, index: true
      t.integer :usage_limit, defualt: 0, index: true
      t.integer :usage_count, default: 0, index: true
      t.datetime :expires_at, index: true

      t.timestamps null: false, index: true
    end
  end
end
