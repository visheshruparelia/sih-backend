class MakeIsdepartmentFalse < ActiveRecord::Migration[5.1]
  def change
    change_column :groups, :isDepartment, :boolean, :default => false
  end
end
