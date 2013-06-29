class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :name, :null => false
      t.string :value

      t.timestamps
    end
    add_index :configurations, :name
  end
end
