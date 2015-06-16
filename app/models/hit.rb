class Hit < ActiveRecord::Base
	belongs_to :search
	has_one :user, through: :search

end
