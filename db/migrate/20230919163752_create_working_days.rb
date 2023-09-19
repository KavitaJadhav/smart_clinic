class CreateWorkingDays < ActiveRecord::Migration[7.0]
  def change
    create_table :working_days do |t|
      t.references :doctor, null: false, index: true, foreign_key: { to_table: :users }
      t.date :date
      t.time :from_time
      t.time :to_time
    end
  end
end
