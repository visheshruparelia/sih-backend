class UpdateFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :files, :name , :string
    add_column :files, :qrcode , :binary
    add_column :files, :timeRecievedCurrentOwner , :datetime
    add_column :files, :status , :integer, default: 0 
    add_column :files, :customData , :binary
    add_column :files, :history , :binary
    add_reference :files, :created_by, foreign_key: {to_table: :users}
    add_reference :files, :currentOwner, foreign_key: {to_table: :users}

  end
end
