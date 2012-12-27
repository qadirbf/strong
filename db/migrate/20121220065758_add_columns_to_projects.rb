class AddColumnsToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :created_by, :integer
    add_column :projects, :updated_by, :integer
    add_index  :projects, :created_by
    add_index  :projects, :updated_by
  end

  def down
    remove_column :projects, :created_by
    remove_column :projects, :updated_by
  end

end
