class Ticket < ActiveRecord::Base
  belongs_to :unit
  belongs_to :doctor
  belongs_to :health_insurance
  belongs_to :patient
  belongs_to :agenda_item
  belongs_to :procedure

  belongs_to :procedure_2, :class_name => "Procedure", :foreign_key => 'procedure_2_id'
  belongs_to :procedure_3, :class_name => "Procedure", :foreign_key => 'procedure_3_id'

  validates_presence_of :unit_id, :doctor_id, :health_insurance, :patient_id, :agenda_item_id, :procedure_id

  def self.list(unit)
    self.where("unit_id = ?", unit).order("created_at DESC")
  end  
end
