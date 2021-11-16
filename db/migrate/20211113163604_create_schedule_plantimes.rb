class CreateSchedulePlantimes < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_plantimes do |t|
      t.string :shift_code
      t.datetime :time_in
      t.datetime :time_out
      t.float :ot_time
      t.references :user
      t.timestamps
    end
  end
end
