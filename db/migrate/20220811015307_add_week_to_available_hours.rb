class AddWeekToAvailableHours < ActiveRecord::Migration[6.1]
  def change
    add_column :available_hours, :week, :integer
  end
end
