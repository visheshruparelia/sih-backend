class Updateschema1 < ActiveRecord::Migration[5.1]
  def change
    add_reference :allfiles, :dept, foreign_key: {to_table: :departments}
  end
end
