class ChangeSearchesPriceLowPriceHigh < ActiveRecord::Migration
  def change
  	rename_column :searches, :price_low, :min_price
  	rename_column :searches, :price_high, :max_price
  end
end
