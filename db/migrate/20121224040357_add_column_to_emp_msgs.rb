class AddColumnToEmpMsgs < ActiveRecord::Migration
  def change
    add_column :emp_msgs, :folder_id, :integer
  end
end
