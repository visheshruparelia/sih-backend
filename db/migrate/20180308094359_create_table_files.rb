class CreateTableFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :files do |t|
      t.timestamps
    end
  end
end
