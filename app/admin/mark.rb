ActiveAdmin.register Mark do
  #TODO: on batch delete the redirect is broken, plz fix
  menu false
  navigation_menu :default
  permit_params :value, :comments, :description, :assignment_id, :user_id, :group_id

  controller do 
    nested_belongs_to :group, :user
  end

  action_item :only => :show do
    link_to 'New Mark', :action => 'new'
  end

  form do |f|
    f.inputs "Details" do
      f.input :user,  
        :as => :select,
        :collection => Hash[User.all.map{|u| [u.first_name + ' ' + u.last_name, u.id]}]
      #TODO: make user collection scoped to only users of current group
      f.input :assignment
      f.input :group
      f.input :description
      f.input :value, :label => "Mark (out of 100)"
      f.input :comments, :as => :text
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :group
      row :value
      row :description
      row :comments
    end
  end


end