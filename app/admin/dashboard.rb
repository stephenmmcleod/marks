ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    panel "Users" do
      average = 0
      count = 0
      table_for User.all do
        column "Name" do |user|
          user.name
        end
        column "current grade" do |user|
          average = average + user.grade
          count += 1 
          user.grade
        end
      end
      h1 average/count
    end

    panel "Marks" do
      table_for Mark.all do
        column "description" do |mark|

          mark.description
        end
        column "value" do |mark|
          mark.value
        end
      end
    end

  end
end
