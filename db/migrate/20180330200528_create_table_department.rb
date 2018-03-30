class CreateTableDepartment < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.references :head, index: true,foreign_key: { to_table: :users }
    end
  end
end
