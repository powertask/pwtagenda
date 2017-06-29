class CreateTicket < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :unit, foreign_key: true
      t.references :agenda_item, foreign_key: true
      t.references :doctor, foreign_key: true
      t.references :patient, foreign_key: true
      t.references :health_insurance, foreign_key: true
      t.references :procedure, foreign_key: true
      t.string :auth_code

      t.timestamps
    end
  end
end
