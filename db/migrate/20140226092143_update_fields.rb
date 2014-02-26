class UpdateFields < ActiveRecord::Migration
  def self.up
  	change_column 	:marks, :comments,  :text
  	remove_column 	:marks, :weight
  end

  def self.down
  	change_column 	:marks, :comments,  :string
  	add_column 		:marks, :weight, :integer
  end
end
