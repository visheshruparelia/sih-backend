class ChangeFiletablename < ActiveRecord::Migration[5.1]
  def change
    rename_table :files, :allfiles
  end
end
