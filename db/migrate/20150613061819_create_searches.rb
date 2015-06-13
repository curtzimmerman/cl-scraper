class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title
      t.string :location
      t.string :location_code
      t.string :query

      t.timestamps null: false
    end
  end
end
