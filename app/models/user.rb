class User < ActiveRecord::Base
	belongs_to :group
	has_many :marks, dependent: :destroy
	accepts_nested_attributes_for :marks
	# accepts_nested_attributes_for :news_images,
 #                            :reject_if => lambda { |attributes| attributes[:photo].blank? },
 #                            :allow_destroy => true
 	def name
 		self.first_name + ' ' + self.last_name
 	end

 	def grade
 		total = 0
 		marks = self.marks
 		marks.each do |mark|
 			total += mark.assignemnt.percent(mark.value.to_i)
 		end
 		total
 	end

end
