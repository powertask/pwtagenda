class PatientsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  layout 'window'

  def index
    @patients = index_class(Patient)
    session[:agenda_item_callback] = ''
    respond_with @patients, :layout => 'application'
  end

  def show
    @patient = Patient.find(params[:id])
    
    @agenda_items = AgendaItem.list(current_user.unit_id).where('patient_id = ?', @patient.id).order('scheduled_to DESC')
    @tickets = Ticket.joins(:agenda_item).list(current_user.unit_id).where('tickets.patient_id = ?', @patient.id).order('scheduled_to DESC')

    respond_with @patient
  end

  def new
    @patient = Patient.new
    @patient.unit_id = current_user.unit_id
    respond_with @patient
  end

  def edit
    @patient = Patient.find(params[:id])
    @patient.unit_id = current_user.unit_id
  end

  def create
    @patient = Patient.new(patient_params)
    
    if @patient.save
      if session[:agenda_item_callback].to_i > 0
        agenda_item_callback = session[:agenda_item_callback]
        session[:agenda_item_callback] = ''
        redirect_to edit_agenda_item_path(agenda_item_callback) and return
      end
    end      
    respond_with @patient
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.update_attributes(patient_params)
    respond_with @patient
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    respond_with @patient
  end

  private

    def patient_params
      params.require(:patient).permit(:unit_id, :health_insurance_doc, :name, :health_insurance_id, :birthday, :gender, :phone, :sms, :email)
    end

end
