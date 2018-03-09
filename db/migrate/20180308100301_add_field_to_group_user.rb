class AddFieldToGroupUser < ActiveRecord::Migration[5.1]
  def change
    add_column :group_users, :defaultIncoming, :boolean
  end
end
