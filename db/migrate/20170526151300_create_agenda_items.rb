class CreateAgendaItems < ActiveRecord::Migration[5.1]
  def change
    create_table :agenda_items do |t|
      t.references :unit, foreign_key: true
      t.references :agenda, foreign_key: true
      t.references :patient, foreign_key: true
      t.datetime :scheduled_to
      t.string :name
      t.string :phone
      t.integer :status
      t.boolean :extra, default: false

      t.timestamps
    end
  end
end
