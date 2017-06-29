Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :rooms
  resources :patients
  resources :health_insurances
  resources :doctors
  resources :units
  resources :agenda_items
  resources :procedure_types
  resources :procedures

  resources :agendas do 
    collection do 
      get :get_events
      get :get_click
    end
  end

  resources :user, :controller => 'users'

  get 'set_attended_event/:cod', to: 'agenda_items#set_attended_event', via: [:get, :post]
  get 'set_not_attended_event/:cod', to: 'agenda_items#set_not_attended_event', via: [:get, :post]
  get 'unset_event/:cod', to: 'agenda_items#unset_event', via: [:get, :post]
  get 'set_new_schedule/:cod', to: 'agenda_items#set_new_schedule', via: [:get, :post]

  get 'delete_agenda/:cod', to: 'agendas#delete_agenda', via: [:get, :post]

  get "home/index"
  get 'dashboard' => 'dashboards#index'

  root to: "home#index"

end
