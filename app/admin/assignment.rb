ActiveAdmin.register Assignment do
  belongs_to :group
  navigation_menu :groups
  permit_params :name, :total_marks, :weight, :group_id

  action_item :only => :show do
    link_to 'New Assignment', :action => 'new'
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
