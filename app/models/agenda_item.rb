class AgendaItem < ActiveRecord::Base
  belongs_to :unit
  belongs_to :agenda
  belongs_to :patient
  
  validates_presence_of :unit_id, :agenda_id

  enum status: [:empty, :marked, :attended, :not_attended]

  def self.list(unit)
    self.where("unit_id = ?", unit).order("name ASC")
  end
  
end
