class AddCheckedToHits < ActiveRecord::Migration
  def change
  	add_column :hits, :checked, :boolean, :default => false
  	add_column :hits, :data_pid, :string 
  end
end