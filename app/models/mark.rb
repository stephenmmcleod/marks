class Mark < ActiveRecord::Base
	belongs_to :user
	belongs_to :assignment
	belongs_to :group
end
