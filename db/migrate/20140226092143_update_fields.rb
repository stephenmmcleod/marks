class UpdateFields < ActiveRecord::Migration
  def self.up
  	change_column 	:marks, :comments,  :text
  	remove_column 	:marks, :weight

  	rename_column 	:users, :role, :comments
  	change_column 	:users, :comments,  :text
  end

  def self.down
  	add_column 		:marks, :weight, :integer
  	rename_column 	:users, :comments, :role
  end
end
