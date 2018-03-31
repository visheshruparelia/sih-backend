class AddReferenceToSection < ActiveRecord::Migration[5.1]
  def change
    add_reference :groups, :dept, foreign_key: {to_table: :departments}
  end
end
