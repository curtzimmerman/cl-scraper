class AddOptionsToSearch < ActiveRecord::Migration
  def change
  	add_column :searches, :price_low, :integer
  	add_column :searches, :price_high, :integer
  	add_column :searches, :url, :string
  end
end
