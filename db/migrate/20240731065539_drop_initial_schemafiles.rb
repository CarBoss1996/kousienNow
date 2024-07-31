class DropInitialSchemafiles < ActiveRecord::Migration[7.1]
  def change
    drop_table :initial_schemafiles
  end
end
