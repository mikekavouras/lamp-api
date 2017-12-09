class AddLastHeardAtToDevice < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :last_heard_at, :datetime
  end
end
