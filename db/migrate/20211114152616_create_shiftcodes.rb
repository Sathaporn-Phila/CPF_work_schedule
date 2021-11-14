class CreateShiftcodes < ActiveRecord::Migration[6.1]
  def change
    create_table :shiftcodes do |t|
      t.string :code_name
      t.datetime :start_in
      t.datetime :end_in
      t.datetime :start_break
      t.datetime :end_break
      t.float :work_time
      t.references :user
      t.timestamps
    end
  end
end
