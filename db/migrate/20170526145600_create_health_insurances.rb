class CreateHealthInsurances < ActiveRecord::Migration[5.1]
  def change
    create_table :health_insurances do |t|
      t.references :unit, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
