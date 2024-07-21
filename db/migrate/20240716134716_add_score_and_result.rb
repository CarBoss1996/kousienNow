class AddScoreAndResult < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :result, :integer
    add_column :matches, :team_score, :integer
    add_column :matches, :away_team_score, :integer
  end
end
