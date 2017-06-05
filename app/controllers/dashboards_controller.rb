class DashboardsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json

  layout 'application'

  def index
    unit = Unit.find(current_user.unit_id)
    doc   = Doctor.list(current_user.unit_id).first
    room  = Room.list(current_user.unit_id).first

    session[:agenda_id] = nil

    unless doc.present?
      redirect_to doctors_path, :alert => "Você precisa cadastrar um profissional." 
      return
    end
    
    unless room.present?
      redirect_to rooms_path, :alert => "Você precisa cadastrar um local para as consultas."
      return
    end

    redirect_to agendas_path
    return
  end

end
