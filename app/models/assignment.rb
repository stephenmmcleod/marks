class Assignment < ActiveRecord::Base
	has_many :marks, dependent: :destroy
	belongs_to :group

	def percent
		value = assignment.mark
		value/self.total_marks
	end
end
