class CreateFileUser < ActiveRecord::Migration[5.1]
  def change
    create_table :file_users do |t|
      t.boolean :modify, :default => false
      t.boolean :view, :default => false
      t.references :fileId, index: true, foreign_key: { to_table: :files }
      t.references :userId, index: true, foreign_key: { to_table: :users }
    end
  end
end
