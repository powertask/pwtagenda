class DoctorsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  layout 'window'

  def index
    @doctors = index_class(Doctor)
    respond_with @doctors, :layout => 'application'
  end

  def show
    @doctor = Doctor.find(params[:id])
    respond_with @doctor
  end

  def new
    @doctor = Doctor.new
    respond_with @doctor
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.unit_id = current_user.unit_id
    @doctor.save
    respond_with @doctor
  end

  def update
    @doctor = Doctor.find(params[:id])
    @doctor.update_attributes(doctor_params)
    respond_with @doctor
  end

  private

    def doctor_params
      params.require(:doctor).permit(:name, :phone, :unit_id, :treatment)
    end

end
