class RemoveTeamIdFromMatches < ActiveRecord::Migration[7.1]
  def change
    remove_column :matches, :team_id, :bigint
  end
end
