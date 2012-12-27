class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer   :user_id
      t.string    :name
      t.string    :description, :limit => 2000
      t.integer   :project_date
      t.string    :tech_info, :limit => 2000
      t.string    :system_config, :limit => 3000
      t.string    :notes, :limit => 2000
      t.string    :index_pic
      t.string    :pic_path
      t.timestamps
    end
  end
end
