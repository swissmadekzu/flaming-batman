class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.string :textmodel
      t.integer :user_id
      t.integer :ticket_id
      t.integer :attachment_id
      t.integer :message_id

      t.timestamps
    end
  end
end
