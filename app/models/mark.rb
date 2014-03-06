class Mark < ActiveRecord::Base
	belongs_to :user
	belongs_to :assignment
	belongs_to :group

	def percent
		(self.value.to_f/self.assignment.total_marks.to_f * 100).round(2) + self.lateness
	end

	def lateness
		late = (self.assignment.due_date.mjd - self.submit_date.mjd) * 10
		if late > 0
			0
		elsif late < -100
			100
		else
			late
		end
	end
end
