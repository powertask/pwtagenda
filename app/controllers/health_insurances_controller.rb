class HealthInsurancesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  layout 'window'

  def index
    @health_insurances = HealthInsurance.list(current_user.unit_id).paginate(:page => params[:page], :per_page => 20)
    respond_with @health_insurances, :layout => 'application'
  end

  def show
    @health_insurance = HealthInsurance.find(params[:id])
    respond_with @health_insurance
  end

  def new
    @health_insurance = HealthInsurance.new
    respond_with @health_insurance
  end

  def edit
    @health_insurance = HealthInsurance.find(params[:id])
  end

  def create
    @health_insurance = HealthInsurance.new(health_insurance_params)
    @health_insurance.unit_id = current_user.unit_id
    @health_insurance.save
    respond_with @health_insurance
  end

  def update
    @health_insurance = HealthInsurance.find(params[:id])
    @health_insurance.update_attributes(health_insurance_params)
    respond_with @health_insurance
  end

  private

    def health_insurance_params
      params.require(:health_insurance).permit(:name, :unit_id)
    end

end
