class ChangeColumnInProjects < ActiveRecord::Migration
  def up
    change_column :projects, :project_date, :date
  end

  def down
    change_column :projects, :project_date, :integer
  end
end
