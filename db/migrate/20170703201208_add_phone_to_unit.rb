class AddPhoneToUnit < ActiveRecord::Migration[5.1]
  def change
  	add_column :units, :phone, :string
  end
end
