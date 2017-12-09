class RemovePresenceFromDevice < ActiveRecord::Migration[5.0]
  def change
    remove_column :devices, :presence
  end
end
