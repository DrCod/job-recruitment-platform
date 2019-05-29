class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :job_name
      t.integer :user_id
      t.text :address
      t.integer :salary_start
      t.integer :salary_end
      t.integer :work_hours
      t.string :job_description

      t.timestamps
    end
  end
end
