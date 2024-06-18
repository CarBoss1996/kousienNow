class ChangeIconInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :locations, :icon, 'integer USING CAST(icon AS integer)'
  end
end
