class Group < ActiveRecord::Base
	has_many :users, dependent: :destroy
	has_many :assignments, dependent: :destroy
	has_many :marks, dependent: :destroy
end
