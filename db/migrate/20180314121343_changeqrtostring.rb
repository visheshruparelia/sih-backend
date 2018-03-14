class Changeqrtostring < ActiveRecord::Migration[5.1]
  def change
    remove_column :allfiles, :qrcode
    add_column :allfiles, :qrcode, :string
  end
end
