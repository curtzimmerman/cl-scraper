class City < ActiveRecord::Base
	has_many :searches
	has_many :hits, through: :searches

	scope :in_order, -> { order(name: :asc) }
end
