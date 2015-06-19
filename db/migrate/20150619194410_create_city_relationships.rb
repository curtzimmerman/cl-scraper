class CreateCityRelationships < ActiveRecord::Migration
  def change
    create_table :city_relationships, id: false do |t|
    	t.references :city
    	t.integer :nearby_city_id, class_name: "City"
    end
  end
end
