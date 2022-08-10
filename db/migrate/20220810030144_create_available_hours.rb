class CreateAvailableHours < ActiveRecord::Migration[6.1]
  def change
    create_table :available_hours do |t|
      t.string :description
      t.string :start_hour
      t.string :end_hour
      t.date :date
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
