class Procedure < ActiveRecord::Base
  belongs_to :unit
  belongs_to :health_insurance
  belongs_to :procedure_type
  
  validates_presence_of :name, :unit_id, :health_insurance_id, :procedure_type_id, :code

  def name_with_type
    "#{procedure_type.name} - #{name}"
  end

  def self.list(unit)
    self.where("unit_id = ?", unit).order("name ASC")
  end
end
