class AddProceduresToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :procedure_2_id, :integer
    add_column :tickets, :procedure_3_id, :integer
    add_column :tickets, :auth_code_2, :string
    add_column :tickets, :auth_code_3, :string
    add_column :tickets, :procedure_description_2, :string
    add_column :tickets, :procedure_description_3, :string
  end
end
