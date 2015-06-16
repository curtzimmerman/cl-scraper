class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
    	t.references :search

    	t.string :url
    	t.string :title
    	t.integer :price
    	t.string :neighborhood

      t.timestamps null: false
    end
  end
end
