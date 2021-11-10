class CreateScheduleActualTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_actual_times do |t|
      t.string :global_position
      t.string :type_attendance
      t.datetime :time_attendance
      t.references :user
      t.timestamps
    end
  end
end
