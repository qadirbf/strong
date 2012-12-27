class CreateCars < ActiveRecord::Migration
  def up
    create_table :cars do |t|
      t.string :name # 车名
      t.string :license # 牌照
      t.datetime :buy_time # 购买时间
      t.datetime :last_check_time # 上次年检时间
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
    add_index :cars, :created_by
    add_index :cars, :updated_by
  end

  def down
    drop_table :cars
  end
end
