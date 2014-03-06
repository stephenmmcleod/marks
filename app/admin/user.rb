ActiveAdmin.register User do
  belongs_to :group
  navigation_menu :groups
  permit_params :role, :first_name, :last_name, :email, :group_id, :description, :comments, :value


  # INDEX

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end
  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end
  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("user", params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end
  

  filter :group
  filter :first_name
  filter :last_name
  filter :email

  index do
    selectable_column
    id_column
    column :group
    column :first_name
    column :last_name
    column :email
    default_actions
  end

  batch_action :change_group, form: {
    group: Group.all.map{|g| [g.name, g.id]} 
  } do |ids, inputs|
    User.find(ids).each do |user|
      user.group_id = inputs["group"]
      user.save!
    end
    redirect_to :action => :index, :notice => "Group id updated!"
  end
  
  # TODO: add multi email later
  # batch_action :email_selected, form: {
  #   message: :text
  # } do |ids, inputs|
  #   User.find(ids).each do |user|
  #     user.group_id = inputs["group"]
  #     user.save!
  #   end
  #   redirect_to :action => :index, :notice => "Group id updated!"
  # end




  # EDIT/SHOW
  
  sidebar "User Tools", only: [:show, :edit] do
    ul :as => "Marks" do
      li link_to 'View Marks', admin_group_user_marks_path(user.group, user)
      li link_to 'Add Mark', new_admin_group_user_mark_path(user.group, user)
      li link_to 'Email Marks', :action => 'email_marks', :params => Hash[:user => user.id]
    end

    ul :as => "user_nav" do
      li link_to 'Next User', edit_admin_group_user_path(user.group, (user.next || User.of_group(mark.user.group).first))
      li link_to 'Previous User', edit_admin_group_user_path(user.group, (user.previous || User.of_group(mark.user.group).last))
    end
  end

  collection_action :email_marks do
    @user = User.find(params[:user])
    MarksMailer.send_message(@user, "Here are your marks thus far.").deliver
    redirect_to admin_group_user_path(@user.group, @user.id), :notice => "The marks have entered the tubes!"
  end


  

  show do |user|    
    attributes_table do
      row :id
      row :group
      row :first_name
      row :last_name
      row :email
      row :comments do
        simple_format(linku(user.comments))
      end
    end
    panel "Marks" do
      table_for user.marks do
        column "assignment" do |mark|
          mark.assignment.name
        end
        column "score" do |mark|
          mark.value
        end
        column "total" do |mark|
          mark.assignment.total_marks
        end
        column "percentage" do |mark|
          text_node (mark.value.to_f/mark.assignment.total_marks.to_f * 100).round(2)
        end
      end
    end
  end



  form do |f|
    f.inputs "Details" do
      f.input :id
      f.input :group
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :comments, :as => "text"
    end
    #TODO: make the editable
    f.has_many :marks, :allow_destroy => true, :heading => 'Marks', :new_record => false do |mark|
      mark.input :description 
      mark.input :comments 
      mark.input :value 
      # mark.inputs :mark do |asd|
      #   raise asd.inspect
      #   link_to("Edit", edit_admin_group_user_mark_path(user.group_id, user.id, ))
        
      # end
    end

    f.actions
  end
end
