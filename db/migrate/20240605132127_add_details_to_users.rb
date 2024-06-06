class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :avatar, :string
    add_column :users, :favorite_player, :string
    add_column :users, :favorite_viewing_block, :integer
  end
end
