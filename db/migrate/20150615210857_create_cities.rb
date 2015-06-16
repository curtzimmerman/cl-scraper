class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
    	t.string :name
    	t.string :url

      t.timestamps null: false
    end

    remove_column :searches, :location
    remove_column :searches, :location_code
    add_column :searches, :location, :integer
  end
end
