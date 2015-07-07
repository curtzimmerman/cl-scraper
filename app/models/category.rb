class Category < ActiveRecord::Base
	has_many :searches

	scope :in_order, -> { order(name: :asc) }
end
