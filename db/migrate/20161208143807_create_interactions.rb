class CreateInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :interactions do |t|
      t.integer :user_id, index: true
      t.integer :user_device_id, index: true
      t.integer :photo_id, index: true
      t.string :name
      t.text :description
      t.integer :red, default: 0
      t.integer :green, default: 0
      t.integer :blue, default: 0
      t.string :pattern

      t.timestamps null: false, index: true
    end
  end
end
