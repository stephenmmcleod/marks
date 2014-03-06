ActiveAdmin.register Assignment do
  belongs_to :group
  navigation_menu :groups
  permit_params :name, :total_marks, :weight, :group_id

  action_item :only => :show do
    link_to 'New Assignment', :action => 'new'
  end

  action_item :only => :index do
    link_to 'Create User Marks', :action => 'create_user_marks', :params => Hash[:group => assignments.first.group_id]
  end

  batch_action :create_user_marks do |ids|
    assignments = Assignment.find(ids)
    group = assignments.first.group_id
    users = User.all.of_group(group)
    assignments.each do |assignment|
      users.each do |user|
        mark = Mark.new(
          user_id: user.id,
          group_id: user.group_id,
          assignment_id: assignment.id,
          value: assignment.total_marks,
          description: assignment.name,
          comments: "",
        )
        mark.save!
      end
    end
    redirect_to admin_group_assignments_path(group), :notice => "The marks have been created!"
  end

  collection_action :create_user_marks do
    assignments = Assignment.all
    users = User.all.of_group(group)

    assignments.each do |assignment|
      users.each do |user|
        mark = Mark.new(
          user_id: user.id,
          group_id: user.group_id,
          assignment_id: assignment.id,
          value: assignment.total_marks,
          description: assignment.name,
          comments: "",
        )
        mark.save!
      end
    end
    redirect_to admin_group_assignments_path(group), :notice => "The marks have been created!"
  end

  show do
    attributes_table do
      row :id
      row :group
      row :name
      row :total_marks
      row :weight
    end
    panel "Marks" do
      table_for assignment.marks do
        column "user" do |mark|
          mark.user.name
        end
        column "score" do |mark|
          mark.value
        end
        column "total" do |mark|
          assignment.total_marks
        end
        column "percentage" do |mark|
          text_node (mark.value.to_f/assignment.total_marks.to_f * 100).round(2)
        end
      end
    end
  end
end
