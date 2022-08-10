class CreateEngineers < ActiveRecord::Migration[6.1]
  def change
    create_table :engineers do |t|
      t.string :name
      t.string :color
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
