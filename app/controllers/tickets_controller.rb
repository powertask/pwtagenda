class TicketsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  layout 'window'

  def index
    @tickets = Ticket.list(current_user.unit_id).paginate(:page => params[:page], :per_page => 20)
    respond_with @tickets, :layout => 'application'
  end

  def show
    @ticket = Ticket.find(params[:id])
    respond_with @ticket
  end

  def new
    @ticket = Ticket.new
    respond_with @ticket
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.unit_id = current_user.unit_id
    @ticket.save
    respond_with @ticket
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update_attributes(ticket_params)
    respond_with @ticket
  end


  def new_ticket_from_agenda
    agenda_item = AgendaItem.list(current_user.unit_id).where('id = ?', params[:cod])[0]
    agenda      = Agenda.list(current_user.unit_id).where('id = ?', agenda_item.agenda_id)[0]

    @ticket = Ticket.new
    @ticket.unit_id = current_user.unit_id
    @ticket.agenda_item_id = agenda_item.id
    @ticket.health_insurance_id = agenda_item.patient.health_insurance_id
    @ticket.doctor_id = agenda.doctor_id
    @ticket.patient_id = agenda_item.patient_id
    @ticket.created_at = Time.current
    
  end

  def create_ticket_from_agenda
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      if AgendaItem.set_attended_event(@ticket.agenda_item_id)
        redirect_to root_path, notice: 'Consulta confirmada! Ticket gerado para faturamento.'
      else
        redirect_to root_path, alert: 'Não foi possível gravar o agendamento como efetivado!'
      end
    else
      redirect_to new_ticket_from_agenda_path(@ticket.agenda_item_id), alert: 'Todos os campos devem ser preenchidos.'
    end
  end


  private
    def ticket_params
      params.require(:ticket).permit(:unit_id, :procedure_description, :agenda_item_id, :health_insurance_id, :doctor_id, :patient_id, :procedure_id, :auth_code, :procedure_2_id, :procedure_3_id, :auth_code_2, :auth_code_3, :procedure_description_2, :procedure_description_3)
    end

end
