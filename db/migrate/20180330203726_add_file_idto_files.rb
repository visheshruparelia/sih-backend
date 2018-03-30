class AddFileIdtoFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :allfiles, :fileId,:integer, :default=>0,:null=>false
  end
end
