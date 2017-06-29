class ProcedureTypesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  layout 'window'

  def index
    @procedure_types = ProcedureType.list(current_user.unit_id).paginate(:page => params[:page], :per_page => 20)
    respond_with @procedure_types, :layout => 'application'
  end

  def show
    @procedure_type = ProcedureType.find(params[:id])
    respond_with @procedure_type
  end

  def new
    @procedure_type = ProcedureType.new
    respond_with @procedure_type
  end

  def edit
    @procedure_type = ProcedureType.find(params[:id])
  end

  def create
    @procedure_type = ProcedureType.new(procedure_type_params)
    @procedure_type.unit_id = current_user.unit_id
    @procedure_type.save
    respond_with @procedure_type
  end

  def update
    @procedure_type = ProcedureType.find(params[:id])
    @procedure_type.update_attributes(procedure_type_params)
    respond_with @procedure_type
  end

  private

    def procedure_type_params
      params.require(:procedure_type).permit(:name, :unit_id)
    end

end
