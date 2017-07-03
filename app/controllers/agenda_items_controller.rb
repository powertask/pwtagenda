class AgendaItemsController < ApplicationController
  before_action :authenticate_user!

  respond_to :html, :json
  layout 'window'
  
  def show
    @agenda_item = AgendaItem.find(params[:id])
    respond_with(@agenda_item)
  end

  def new
    @agenda = Agenda.find(session[:agenda_id])

    @agenda_item = AgendaItem.new
    @agenda_item.agenda_id = session[:agenda_id]
    @agenda_item.unit_id = current_user.unit_id
    @agenda_item.status = :marked
    @agenda_item.extra = true
    respond_with(@agenda_item)
  end

  def edit
    session[:agenda_item_callback] = params[:id]
    @agenda_item = AgendaItem.find(params[:id])
    @agenda = Agenda.find(@agenda_item.agenda_id)
  end

  def create
    @agenda_item = AgendaItem.new(agenda_item_params)

    if @agenda_item.scheduled_to < Date.current
      redirect_to(agendas_path, alert: 'Você não pode agendar para horários passados') and return
    end

    @agenda_item.save

    @agenda = Agenda.find(@agenda_item.agenda_id)

    redirect_to(agendas_path, notice: 'Encaixe na agenda criado com sucesso')
  end

  def update
    session[:agenda_item_callback] = ''
    @agenda_item = AgendaItem.find(params[:id])
    @agenda_item.status = :marked
    @agenda_item.update_attributes(agenda_item_params)

    PatientMailer.notify_new_schedule(@agenda_item).deliver_later

    redirect_to(agendas_path, notice: 'Agendamento efetuado com sucesso')
  end
  

  def set_not_attended_event
    id = params[:cod]
    agenda_item = AgendaItem.where('id = ?', id)[0]
    agenda_item.not_attended!
    agenda_item.save

    redirect_to controller: 'agendas', action: "index", layout: "application"
  end
  

  def set_unmarked_event
    @agenda_item = AgendaItem.find params[:cod]

    begin
      ActiveRecord::Base.transaction do
        agenda_item = AgendaItem.new
        agenda_item.unit_id = @agenda_item.unit_id
        agenda_item.agenda_id = @agenda_item.agenda_id
        agenda_item.scheduled_to = @agenda_item.scheduled_to
        agenda_item.status = :empty
        agenda_item.extra = false
        agenda_item.save

        @agenda_item.status = :unmarked
        @agenda_item.save
      end
      rescue ActiveRecord::RecordInvalid => e
        puts e.record.errors.full_messages      
    end
    redirect_to agendas_path
  end
  

  private

    def validate_scheduled
      record = AgendaItem.find(params[:id])

      agenda = Agenda.find(record.agenda_id)
      agenda_item = AgendaItem.where('unit_id = ? and ' <<
                                'scheduled_to between ? and ? and ' <<
                                'patient_id > 0 ',
                                record.unit_id,
                                record.scheduled_to,
                                record.scheduled_to)

      if agenda_item.count > 0 && record.doctor_id != agenda_item[0][:doctor_id]
        redirect_to agenda_items_path, alert: t('agenda_item.not_available')
      end

    end

    def agenda_item_params
      params.require(:agenda_item).permit( :extra, :scheduled_to, :patient_id, :room_id, :doctor_id, :phone, :status, :unit_id, :agenda_id)
    end

end
