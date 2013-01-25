class AddCategoryToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :category_id, :integer
    add_column :projects, :sub_category_id, :integer
    add_index :projects, :category_id
    add_index :projects, :sub_category_id
  end

  def down
    remove_column :projects, :category_id
    remove_column :projects, :sub_category_id
  end
end
