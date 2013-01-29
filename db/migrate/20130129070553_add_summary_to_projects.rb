class AddSummaryToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :summary, :string, :limit => 2000
  end

  def down
    remove_column :projects, :summary
  end
end
