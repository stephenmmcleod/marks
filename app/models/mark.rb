class Mark < ActiveRecord::Base
    belongs_to :user
    belongs_to :assignment
    belongs_to :group

    default_scope { order('submit_date ASC') }

    def percent
        m = (self.value.to_f/self.assignment.total_marks.to_f * 100).round(2) + self.lateness
        if m < 0
            m = 0.round(2)
        end
        m
    end

    def weighted_mark
        (self.percent/100) * self.assignment.total_marks
    end

    def lateness
        if self.submit_date.present? && self.assignment.due_date.present?
            late = (self.assignment.due_date.mjd - self.submit_date.mjd) * 10
            if late > 0
                0
            elsif late < -100
                -100
            else
                late
            end
        else
            -100
        end 
    end
end
