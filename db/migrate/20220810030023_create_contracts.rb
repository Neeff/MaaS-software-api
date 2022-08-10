class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.json :business_days
      t.integer :init_hour
      t.integer :finish_hour
      t.integer :init_weekend_hour
      t.integer :finish_weekend_hour
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
