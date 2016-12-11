class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :user_id, index: true
      t.integer :interaction_id, index: true
      t.text :response
      t.text :error
      t.string :status, index: true

      t.timestamps null: false, index: true
    end
  end
end
