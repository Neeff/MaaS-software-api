class AddActiveToShift < ActiveRecord::Migration[6.1]
  def change
    add_column :shifts, :active, :boolean, default: true
  end
end
