class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.string   :name
      t.string   :email
      t.string   :phone
      t.string   :company
      t.string   :message
      t.integer  :status_id
      t.timestamps
    end
    add_index  :messages, :status_id
  end

  def down
    drop_table  :messages
  end
end
