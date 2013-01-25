class CreateSubCategories < ActiveRecord::Migration
  def up
    create_table :sub_categories do |t|
      t.string :name
      t.integer :category_id
      t.timestamps
    end
    add_index :sub_categories, :category_id
  end

  def down
    drop_table :sub_categories
  end
end
