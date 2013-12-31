class AddColorToEmergency < ActiveRecord::Migration
  def change
    add_column :emergencies, :color, :string
  end
end
