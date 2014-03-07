ActiveAdmin.register Mark do
  #TODO: on batch delete the redirect is broken, plz fix
  menu false
  navigation_menu :default
  permit_params :value, :comments, :description, :assignment_id, :user_id, :group_id, :submit_date

  controller do 
    nested_belongs_to :group, :user
  end



  action_item :only => :show do
    link_to 'New Mark', :action => 'new'
  end

  action_item do
    span :style => "margin: 0 20px;" do
      user.name + " " + user.grade.to_s
    end
  end

  action_item do
    link_to 'Previous User', admin_group_user_marks_path(user.group, (user.previous || User.of_group(user.group).first))
  end

  action_item do
    link_to 'Next User', admin_group_user_marks_path(user.group, (user.next || User.of_group(user.group).last))
  end

  batch_action :set_date, form: {
    date:   :datepicker
  } do |ids, inputs|
    x = ""
    Mark.find(ids).each do |mark|
      mark.submit_date = inputs["date"]
      mark.save!
      x = mark
    end
    redirect_to admin_group_user_marks_path(x.group, x.user), :notice => "Date updated!"
  end

  index :title => "Marks" do
    selectable_column
    id_column
    column :value
    column :description do |mark|
      linku(mark.description)
    end
    column :lateness do |mark|
      mark.lateness.to_s + "%"
    end
    column :total do |mark|
      mark.percent.to_s + "%"
    end
    column :comments do |mark|
      truncate(mark.comments, omision: "...", length: 100)
    end
    default_actions
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
      f.input :submit_date, :as => :datepicker
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :group
      row :value
      row :description do |mark|
        linku(mark.description)
      end
      row :comments
      row :submit_date
    end
  end


end