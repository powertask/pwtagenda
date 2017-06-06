class AddCarteiraToPatient < ActiveRecord::Migration[5.1]
  def change
  	add_column :patients, :health_insurance_doc, :string
  end
end
