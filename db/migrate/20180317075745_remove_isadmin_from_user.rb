class RemoveIsadminFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :isAdmin
  end
end
