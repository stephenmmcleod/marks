class RemoveCommentsTable < ActiveRecord::Migration
  def self.up
    drop_table :active_admin_comments
  end
  def self.down
    create_table :active_admin_comments do |t|
      t.string :namespace
      t.text   :body
      t.string :resource_id,   :null => false
      t.string :resource_type, :null => false
      t.references :author, :polymorphic => true
      t.timestamps
    end
    add_index :active_admin_comments, [:namespace]
    add_index :active_admin_comments, [:author_type, :author_id]
    add_index :active_admin_comments, [:resource_type, :resource_id]
  end
end
