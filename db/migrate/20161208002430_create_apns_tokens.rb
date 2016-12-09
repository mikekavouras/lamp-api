class CreateApnsTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :apns_tokens do |t|
      t.integer :user_id, index: true
      t.boolean :active, index: true
      t.string :token

      t.timestamps null: false, index: true
    end
  end
end
