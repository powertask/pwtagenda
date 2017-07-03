class AddProcedureDescriptionToTicket < ActiveRecord::Migration[5.1]
  def change
  	add_column :tickets, :procedure_description, :string
  end
end
