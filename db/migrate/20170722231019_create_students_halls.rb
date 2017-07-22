class CreateStudentsHalls < ActiveRecord::Migration[5.1]
  def change
    create_table :students_halls do |t|
      t.string :names
      t.string :contact_no

      t.timestamps
    end
  end
end
