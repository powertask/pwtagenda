class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.references :unit, foreign_key: true
      t.string :treatment
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
