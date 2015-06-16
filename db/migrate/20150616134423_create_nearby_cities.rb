class CreateNearbyCities < ActiveRecord::Migration
  def change
    create_table :nearby_cities, { id: false } do |t|
    	t.references :home_city, class_name: "City", index: true, foreign_key: true
    	t.references :city, index: true, foreign_key: true

    end

    add_index :searches, :user_id, name: 'user_id_ix'
  end
end
