class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.references :unit, foreign_key: true
      t.string :name, :limit => 80
      t.references :health_insurance, foreign_key: true
      t.date :birthday
      t.string :gender, :limit => 1
      t.string :phone
      t.string :sms
      t.string :email

      t.timestamps
    end
  end
end
