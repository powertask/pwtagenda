class UnitsController < ApplicationController
  before_action :authenticate_user!
  
  respond_to :html
  layout 'window'

  def index
    @units = index_class(Unit, type: :id)
    respond_with(@units, layout: 'application')
  end

  def show
    @unit = Unit.find(params[:id])
    respond_with @unit
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    @unit.update_attributes(unit_params)
    respond_with(@unit)
  end

  def filter
    @units = filter_class(Unit)

    respond_to do |format|
      format.html { render :action => "index"}
    end
  end
  
  private
    def unit_params
      params.require(:unit).permit(:name, :phone, :profile, :cnpj, :zipcode, :state, :city_name, :address, :address_complement, :neighborhood, :email)
    end
    
end
