class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :content
      t.datetime :time
      t.integer :user_id

      t.timestamps
    end
    add_index :reminders, [:user_id, :time]
  end
end
