class AddFieldsToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :neighbourhood, :string
    add_column :nodes, :city, :string
    add_column :nodes, :street, :string
  end
end
