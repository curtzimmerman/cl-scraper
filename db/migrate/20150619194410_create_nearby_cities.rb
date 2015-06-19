class CreateNearbyCities < ActiveRecord::Migration
  def change
    create_table :nearby_cities, id: false do |t|
    	t.references :city
    	t.integer :nearby_city_id, class_name: "City"
    end
  end
end
