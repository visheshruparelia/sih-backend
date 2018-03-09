class AddFieldToUsersGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_reference :users, :department, foreign_key: { to_table: :groups}
    add_column :groups, :name, :string
    add_column :groups, :isDepartment, :boolean
  end
end
