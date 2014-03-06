class AddHandInTimeToAssignmentsAndMarks < ActiveRecord::Migration
  def change
  	add_column 	:assignments, :due_date, :date
  	add_column 	:marks, :submit_date, :date
  end
end
