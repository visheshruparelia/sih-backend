class Updateschema2 < ActiveRecord::Migration[5.1]
  def change
    remove_column :departments, :depId
    remove_column :allfiles, :fileId
    add_column :allfiles, :fileId, :string
    add_column :departments, :depId, :string
  end
end
