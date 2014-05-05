class AddSupervisorToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_supervisor, :boolean, default: false
  end
end
