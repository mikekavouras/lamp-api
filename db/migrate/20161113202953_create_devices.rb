class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :particle_id
      t.json :params

      t.timestamps null: false, index: true
    end

    add_index :devices, :particle_id, unique: true
  end
end
