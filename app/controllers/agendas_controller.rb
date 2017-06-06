class AgendasController < ApplicationController
  before_action :authenticate_user!

  respond_to :html, :js, :json
  layout 'window'
  
  def index
    if session[:agenda_id].nil?
      @agenda = Agenda
                .includes(:room, :doctor)
                .where('unit_id = ? and agenda_date >= ?', current_user.unit_id, Date.current )
                .order(:agenda_date)[0]
    else
      @agenda = Agenda.find(session[:agenda_id])
    end

    if @agenda
      @agenda_items = AgendaItem.where('agenda_id = ?', @agenda.id).order('scheduled_to ASC')
      session[:agenda_id] = @agenda.id 
    else
      @agenda_items = []
    end

    respond_with(@agenda, :layout => 'application')
  end

  def get_events
    @agendas = Agenda.includes(:room, :doctor).where("unit_id = ?", current_user.unit_id)

    events = []
    @agendas.each do |event|
      events << { :id => event.id, 
                  :title => event.doctor.treatment + " " + event.doctor.name + "\n" + event.room.name,
                  :className => 'btn btn-xs btn-primary', 
                  :description => '',
                  :start => "#{event.agenda_date}", 
                  :end => "#{event.agenda_date}", 
                  :allDay => true, 
                  :recurring => false}
    end
    render :json => events.to_json
  end

  def get_click
    @agenda = Agenda.find(params[:id])
    @agenda_items = AgendaItem.where('agenda_id = ?', params[:id]).order('scheduled_to ASC')

    session[:agenda_id] = params[:id]

    respond_to do |format|
      format.js
    end
  end
  
  def show
    @agenda = Agenda.find(params[:id])
    respond_with @agenda
  end

  def new
    @agenda = Agenda.new
    @agenda.interval = 30
    @agenda.count_event = 1
    @agenda.unit_id = current_user.unit_id
    respond_with @agenda
  end

  def edit
    @agenda = Agenda.find(params[:id])
  end

  def create
    @agenda = Agenda.new(agenda_params)
    
    if !@agenda.save
      respond_with @agenda
      return
    end

    time_between_schedule = @agenda.interval * 60

    year_ = @agenda.agenda_date.year
    month_ = @agenda.agenda_date.month
    day_ =  @agenda.agenda_date.day
    hour_ini_ = @agenda.start_at.hour
    hour_end_ = @agenda.end_at.hour
    min_ini_ = @agenda.start_at.min
    min_end_ = @agenda.end_at.min


    first_time = Time.zone.local(year_, month_, day_, hour_ini_, min_ini_, 0)
    end_time = Time.zone.local(year_, month_, day_, hour_end_, min_end_, 0)

    current_time = first_time

    while current_time <= end_time do
      
      if @agenda.count_event.nil? || @agenda.count_event == 0
        @agenda.count_event = 1
      end
      
      (1..@agenda.count_event).each do |i|
        agenda_item = AgendaItem.new
        agenda_item.unit_id = current_user.unit_id
        agenda_item.agenda_id = @agenda.id
        agenda_item.scheduled_to = current_time
        agenda_item.status = :empty
        agenda_item.save
      end
      current_time = current_time.since(time_between_schedule)
    end

    redirect_to root_path, notice: 'Agenda criada com sucesso.'
  end


  def update
    @agenda = Agenda.find(params[:id])
    @agenda.update_attributes(agenda_params)
    respond_with(@agenda)
  end


  def delete_agenda
    @agenda = Agenda.find params[:cod]
    
    agenda_items = AgendaItem.where("agenda_id = ?", params[:cod])
    agenda_items.each do |event|
      if not event.empty?
        flash[:alert] = t('agenda_item.not_deleted')
        redirect_to agendas_path and return
      end
    end
    
    @agenda.destroy
    redirect_to root_path
  end

  private
    def agenda_params
      params.require(:agenda).permit(:unit_id, :name, :doctor_id, :agenda_date, :end_at, :interval, :start_at, :room_id, :count_event)
    end
end
