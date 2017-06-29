class CreateProcedure < ActiveRecord::Migration[5.1]
  def change
    create_table :procedures do |t|
      t.references :unit, foreign_key: true
      t.references :procedure_type, foreign_key: true
      t.references :health_insurance, foreign_key: true
      t.string :code
      t.string :name
      t.decimal :copart_value
      t.decimal :health_insurance_value
      t.decimal :cho

      t.timestamps
    end
  end
end
