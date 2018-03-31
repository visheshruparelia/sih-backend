class Updateschema3 < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :dept, foreign_key: {to_table: :departments}
    add_reference :users, :sec, foreign_key: {to_table: :groups}
  end
end
