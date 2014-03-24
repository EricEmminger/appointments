class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :first_name
      t.string :last_name
      t.text :comments

      t.timestamps
    end
    add_index :appointments, :start_time, unique: true
    add_index :appointments, :end_time, unique: true
  end
end
