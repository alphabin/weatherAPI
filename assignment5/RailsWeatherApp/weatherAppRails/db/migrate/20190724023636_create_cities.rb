class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :population
      t.string :country
      t.string :description

      t.timestamps
    end
  end
end
