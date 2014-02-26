ActiveAdmin.register Group do

  sidebar "Group Tools", only: [:show, :edit] do
    ul :as => "Users" do
      li link_to("Users", admin_group_users_path(group))
      li link_to 'New User', new_admin_group_user_path(group)
    end
    ul :as => "Assignments" do
      li link_to("Assignments", admin_group_assignments_path(group))
      li link_to 'New Assignment', new_admin_group_assignment_path(group)
    end
  end

  permit_params :name, :description

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
    end
    f.actions
  end
  
end
