class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.references :engineer, null: false, foreign_key: true
      t.string :starts_at
      t.string :ends_at
      t.date :date

      t.timestamps
    end
  end
end
