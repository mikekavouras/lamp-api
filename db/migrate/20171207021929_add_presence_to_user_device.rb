class AddPresenceToUserDevice < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :presence, :boolean, default: false
  end
end
