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
    @agenda_item = AgendaItem.find(params[:id])
    @agenda_item.status = :marked
    @agenda_item.update_attributes(agenda_item_params)

    PatientMailer.notify_new_schedule(@agenda_item).deliver_later

    redirect_to agendas_path
  end
  
  def filter
    @date = params[:agenda_date][:day].gsub(/[\/]/, '')
    @start_date = Date.new(@date[4,4].to_i, @date[2,2].to_i, @date[0,2].to_i)
    @end_date = @start_date.to_s << " 23:59:59"
    @doctor = params[:doctor].to_i

    unless @doctor == 0
      @agenda_items = AgendaItem.where("unit_id = ? and doctor_id = ? and agenda_date between ? and ?", current_user.unit_id, @doctor, @start_date, @end_date).paginate(:page => params[:page]).order('doctor_id, agenda_date, scheduled_to ASC')
    else
      @agenda_items = AgendaItem.where("unit_id = ? and agenda_date between ? and ?", current_user.unit_id, @start_date, @end_date).paginate(:page => params[:page]).order('doctor_id, agenda_date, scheduled_to ASC')
    end

    respond_to do |format|
      format.html { render :action => "index", :layout => "application"}
    end
  end

  def set_attended_event
    id = params[:cod]
    agenda_item = AgendaItem.where('id = ?', id)[0]
    agenda_item.update_column("status", 2)

    redirect_to controller: 'agendas', action: "index", layout: "application"
  end
  
  def set_not_attended_event
    id = params[:cod]
    agenda_item = AgendaItem.where('id = ?', id)[0]
    agenda_item.not_attended!
    agenda_item.save

    redirect_to controller: 'agendas', action: "index", layout: "application"
  end
  
  def unset_event
    @agenda_item = AgendaItem.find params[:cod]
    @agenda_item.name = nil
    @agenda_item.phone = nil
    @agenda_item.patient_id = nil
    @agenda_item.status = :empty
    @agenda_item.save
    redirect_to agendas_path
  end
  
  def set_new_schedule
    id = params[:cod]
    agenda_item = AgendaItem.where('id = ?', id)[0]
  
    @agenda_item = AgendaItem.new
    @agenda_item.schedule_setup_id = agenda_item.schedule_setup_id
    @agenda_item.room_id = agenda_item.room_id
    @agenda_item.doctor_id = agenda_item.doctor_id
    @agenda_item.day_of_month = agenda_item.day_of_month
    @agenda_item.scheduled_at = agenda_item.scheduled_at
    
    respond_with @agenda_item
    
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
