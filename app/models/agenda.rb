class Agenda < ActiveRecord::Base
  belongs_to :unit
  belongs_to :room
  belongs_to :doctor

  has_many :agenda_items, dependent: :destroy

  validates_presence_of :unit_id, :room_id, :doctor_id, :agenda_date

  def self.list(unit)
    self.where("unit_id = ?", unit).order("name ASC")
  end
  
end
