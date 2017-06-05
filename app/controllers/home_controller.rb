class HomeController < ApplicationController
  
  respond_to :html, layout: false

  def index
    if current_user
      redirect_to(controller: 'dashboards', action: 'index')
    end
  end

end
