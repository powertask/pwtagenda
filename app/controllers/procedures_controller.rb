class ProceduresController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  layout 'window'

  def index
    @procedures = index_class(Procedure)
    respond_with @procedures, :layout => 'application'
  end

  def show
    @procedure = Procedure.find(params[:id])
    respond_with @procedure_type
  end

  def new
    @procedure = Procedure.new
    respond_with @procedure
  end

  def edit
    @procedure = Procedure.find(params[:id])
  end

  def create
    @procedure = Procedure.new(procedure_params)
    @procedure.unit_id = current_user.unit_id
    @procedure.save
    respond_with @procedure
  end

  def update
    @procedure = Procedure.find(params[:id])
    @procedure.update_attributes(procedure_params)
    respond_with @procedure
  end

  private

    def procedure_params
      params.require(:procedure).permit(:name, :unit_id, :procedure_type_id, :health_insurance_id, :code, :copart_value, :health_insurance_value, :cho)
    end

end
