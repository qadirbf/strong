class AddOrderNumToTables < ActiveRecord::Migration
  def up
    add_column :categories, :order_num, :integer
    add_column :sub_categories, :order_num, :integer
    add_column :projects, :order_num, :integer
    add_column :projects, :published, :integer, :limit => 2
  end

  def down
    remove_column :categories, :order_num
    remove_column :sub_categories, :order_num
    remove_column :projects, :order_num
    remove_column :projects, :published
  end
end
