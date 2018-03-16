class AddIsadminToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :isAdmin, :boolean
  end
end
