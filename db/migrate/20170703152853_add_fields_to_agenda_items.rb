class AddFieldsToAgendaItems < ActiveRecord::Migration[5.1]
  def change
    add_column :agenda_items, :unmarked_description, :string
    add_column :agenda_items, :unmarked_user_id, :string
    add_column :agenda_items, :unmarked_by_patient, :boolean
    add_column :agenda_items, :unmarked_datetime, :datetime
  end
end
