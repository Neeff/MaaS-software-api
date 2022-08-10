class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :company_name
      t.integer :weekly_hours

      t.timestamps
    end
  end
end
