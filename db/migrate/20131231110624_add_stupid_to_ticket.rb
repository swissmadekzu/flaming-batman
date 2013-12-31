class AddStupidToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :stupid, :boolean
  end
end
