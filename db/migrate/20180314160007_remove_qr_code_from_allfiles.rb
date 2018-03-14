class RemoveQrCodeFromAllfiles < ActiveRecord::Migration[5.1]
  def change
      remove_column :allfiles, :qrcode
  end
end
