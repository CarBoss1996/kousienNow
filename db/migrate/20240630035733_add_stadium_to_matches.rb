class AddStadiumToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :stadium, :string
  end
end
