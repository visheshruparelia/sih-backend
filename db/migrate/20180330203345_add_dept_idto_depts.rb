class AddDeptIdtoDepts < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :deptId,:integer, :default=>0,:null=>false
  end
end
