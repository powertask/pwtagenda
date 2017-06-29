class Ticket < ActiveRecord::Base
  belongs_to :unit
  belongs_to :doctor
  belongs_to :health_insurance
  belongs_to :patient
  belongs_to :agenda_item
  belongs_to :procedure

  validates_presence_of :unit_id, :doctor_id, :health_insurance, :patient_id, :agenda_item_id, :procedure_id, :auth_code

  def self.list(unit)
    self.where("unit_id = ?", unit).order("name ASC")
  end  
end
