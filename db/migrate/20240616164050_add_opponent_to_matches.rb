class AddOpponentToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :opponent, :integer
  end
end
