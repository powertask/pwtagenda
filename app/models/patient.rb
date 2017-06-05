class Patient < ActiveRecord::Base
  belongs_to :unit
  belongs_to :health_insurance

  has_many :agenda_items

  validates_presence_of :birthday, :name, :health_insurance_id, :unit_id

  def self.list(unit)
    self.where("unit_id = ?", unit).order("name ASC")
  end
  
end

