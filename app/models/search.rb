class Search < ActiveRecord::Base
	belongs_to :user

	validates :title, presence: true, length: { maximum: 50 }
	validates :location, presence: true
	validates :query, presence: true, length: { maximum: 255 }
end
