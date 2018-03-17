class AddPriorityToFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :allfiles, :priority, :integer, default: 0
  end
end
