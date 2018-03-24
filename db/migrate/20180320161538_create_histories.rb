class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.timestamps
      t.references :changed_by, index: true, foreign_key: { to_table: :user }
      t.references :file, foreign_key: true
      t.datetime :change_time
      t.integer :status_from
      t.integer :status_to
    end
  end
end
