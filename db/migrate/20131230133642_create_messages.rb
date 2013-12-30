class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :ticket_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
