class AddHourTimeToTicket < ActiveRecord::Migration[5.1]
  def change
  	add_column :tickets, :ticket_datetime, :datetime
  	add_column :tickets, :ticket_date, :date
  	add_column :tickets, :ticket_time, :time
  end
end
