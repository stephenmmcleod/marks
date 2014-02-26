class InitialSchema < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.column :name, :string
      t.column :description, :string
    end

    create_table :users do |t|
      t.column :group_id, :integer
      t.column :role, :string
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :email, :string
    end

    add_index  :users, :group_id

    create_table :assignments do |t|
      t.column :group_id, :integer
      t.column :name, :string
      t.column :total_marks, :integer
      t.column :weight, :integer
    end

    add_index  :assignments, :group_id

    create_table :marks do |t|
      t.column :user_id, :integer
      t.column :group_id, :integer
      t.column :assignment_id, :integer
      t.column :value, :integer
      t.column :weight, :integer
      t.column :description, :string
      t.column :comments, :string
    end

    add_index  :marks, :group_id
    add_index  :marks, :user_id
    add_index  :marks, :assignment_id

  end
end