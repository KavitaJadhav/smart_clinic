class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, index: true, foreign_key: { to_table: :users }
      t.references :patient, null: false, index: true, foreign_key: { to_table: :users }
      t.date :date
      t.time :from_time
      t.time :to_time
      t.string :status

      t.timestamps
    end
  end
end
