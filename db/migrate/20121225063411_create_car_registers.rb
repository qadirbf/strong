class CreateCarRegisters < ActiveRecord::Migration
  def up
    create_table :car_registers do |t|
      t.integer  :user_id
      t.integer  :car_id
      t.string   :apply_reason
      t.datetime :begin_time
      t.datetime :end_time
      t.string   :check_notes
      t.string   :notes, :limit => 1000
      t.integer  :checked_by  # 审核人
      t.timestamps
    end
    add_index :car_registers, :user_id
    add_index :car_registers, :car_id
  end

  def down
    drop_table "car_registers"
  end
end
