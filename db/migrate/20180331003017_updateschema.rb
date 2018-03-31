class Updateschema < ActiveRecord::Migration[5.1]
  def change
    add_column :allfiles, :registeredBy, :string
    add_reference :allfiles, :group_id, foreign_key: {to_table: :groups}
    add_column :histories, :nextNode, :string
  end
end
