Tickets::Application.routes.draw do

  resource  :session, :controller => 'sessions', :only => [:new, :create, :destroy]
  
  #get '/sign_in' => 'sessions#new'
  #match '/sign_out' => 'sessions#destroy', :via => :delete 
  
  root to: "tickets#index"
  resources :tickets do
    collection do
      get 'tech'
    end

    member do
      post "treat"
      post "end_treatment"
    end
  end
  resources :messages
  resources :attachments
  
  get 'supervisor' => "supervisor#index", as: :supervisor_dashboard
  get 'supervisor/:id' => "supervisor#supervise", as: :supervise_ticket

end
