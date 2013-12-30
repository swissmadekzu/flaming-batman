class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :author_id
      t.integer :tech_id
      t.datetime :treatment_date
      t.datetime :end_treatment_date
      t.integer :status_id
      t.integer :category_id
      t.integer :emergency_id

      t.timestamps
    end
  end
end
