class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.references :engineer, null: false, foreign_key: true
      t.string :start_hour
      t.string :end_hour
      t.date :date

      t.timestamps
    end
  end
end
