class AddAvailableHourIdToShift < ActiveRecord::Migration[6.1]
  def change
    add_reference :shifts, :available_hour, null: false, foreign_key: true
  end
end
