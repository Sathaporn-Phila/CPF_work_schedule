class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.string :department_name
      t.datetime :time_in
      t.datetime :time_out
      t.references :user, null: false, foreign_key: true
      t.float :ot_time
      t.timestamps
    end
  end
end
