class CreateGroupGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :group_groups do |t|
      t.references :groupId, index: true, foreign_key: { to_table: :groups }
      t.references :authorityOver, index: true, foreign_key: { to_table: :groups }
      t.timestamps
    end
  end
end
