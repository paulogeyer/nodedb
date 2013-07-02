class AddAddressToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :address, :string
  end
end
