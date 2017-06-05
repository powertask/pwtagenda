class CreateAgendas < ActiveRecord::Migration[5.1]
  def change
    create_table :agendas do |t|
      t.references :unit, foreign_key: true
      t.references :doctor, foreign_key: true
      t.references :room, foreign_key: true
      t.string :name
      t.date :agenda_date
      t.time :start_at
      t.time :end_at
      t.integer :interval
      t.integer :count_event

      t.timestamps
    end
  end
end
