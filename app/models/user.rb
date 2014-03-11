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
    total_marks = 0
    current_marks = 0
    marks = self.marks
    marks.each_with_index do |mark, i|
      current_marks += mark.weighted_mark
      total_marks += mark.assignment.total_marks
    end
    ((current_marks/total_marks) * 100).round(2)
  end

  def total
      
  end

  def next
    User.next(self.id).of_group(self.group_id).first
  end

  def previous
    User.previous(self.id).of_group(self.group_id).first
  end
end
