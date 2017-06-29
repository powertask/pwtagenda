class CreateProcedureType < ActiveRecord::Migration[5.1]
  def change
    create_table :procedure_types do |t|
      t.references :unit, foreign_key: true
      t.references :health_insurance, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
