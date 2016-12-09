class CreateUserDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :user_devices do |t|
      t.integer :user_id
      t.integer :device_id
      t.integer :invite_id
      t.boolean :direct, default: false

      t.timestamps null: false, index: true
    end

    add_index :user_devices, [:user_id, :device_id]
  end
end
