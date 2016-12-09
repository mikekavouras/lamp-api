class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :token
      t.string :filename
      t.string :ext
      t.string :mime_type
      t.integer :original_height
      t.integer :original_width
      t.string :sha
      t.string :ip_address

      t.timestamps
    end
  end
end
