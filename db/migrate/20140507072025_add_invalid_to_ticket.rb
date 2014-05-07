class AddInvalidToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :is_invalid, :boolean
  end
end
