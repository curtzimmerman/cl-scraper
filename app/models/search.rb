class Search < ActiveRecord::Base
	belongs_to :user 
	belongs_to :city

	validates :title, presence: true, length: { maximum: 50 }
	validates :location, presence: true
	validates :query, presence: true, length: { maximum: 255 }
end
