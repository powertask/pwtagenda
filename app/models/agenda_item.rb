class AgendaItem < ActiveRecord::Base
  belongs_to :unit
  belongs_to :agenda
  belongs_to :patient
  
  validates_presence_of :unit_id, :agenda_id

  enum status: [:empty, :marked, :attended, :not_attended]

  def self.list(unit)
    self.where("unit_id = ?", unit).order("name ASC")
  end

  def self.set_attended_event(id)
    agenda_item = AgendaItem.where('id = ?', id)[0]
    agenda_item.status = :attended
    return agenda_item.save
  end
end
