class UpdatePriorityField < ActiveRecord::Migration[5.1]
  def change
    remove_column :allfiles, :priority
    add_column :allfiles, :priority, :integer, default: 0, :null => :false
  end
end
