class AddUserInfos < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email, :string, null: false
    add_column :users, :age, :integer, null: false
  end
end
