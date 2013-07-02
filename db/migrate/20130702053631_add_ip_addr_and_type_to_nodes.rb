class AddIpAddrAndTypeToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :ip_addr, :string
    add_column :nodes, :type, :integer
  end
end
