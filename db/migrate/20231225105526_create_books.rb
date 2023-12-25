class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.integer :weight
      t.timestamps
    end
  end
end
