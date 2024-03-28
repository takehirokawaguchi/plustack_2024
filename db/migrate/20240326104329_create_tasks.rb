class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :state
      t.string :task
      t.date :limit_date
      t.integer :user_id

      t.timestamps
    end
  end
end