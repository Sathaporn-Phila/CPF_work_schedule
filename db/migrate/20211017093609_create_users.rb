class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :employee_id
      t.string :title_name
      t.string :name
      t.string :department
      t.datetime :hire_date
      t.string :employee_type
      t.string :password_digest
      t.string :role
      t.timestamps
    end
  end
end
