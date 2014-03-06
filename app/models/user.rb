class User < ActiveRecord::Base
	scope :next, lambda {|id| where("id > ?",id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }
    scope :of_group, lambda {|group_id| where("group_id = ?",group_id).order("id DESC") }

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


    def next
      User.next(self.id).of_group(self.group_id).first
    end

    def previous
      User.previous(self.id).of_group(self.group_id).first
    end
end
