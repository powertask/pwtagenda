class AddIpasgoCodeToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :ipasgo_code, :string, limit: 10
  end
end
