class CreateEngineerAvailableHours < ActiveRecord::Migration[6.1]
  def change
    create_table :engineer_available_hours do |t|
      t.references :engineer, null: false, foreign_key: true
      t.references :available_hour, null: false, foreign_key: true
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
