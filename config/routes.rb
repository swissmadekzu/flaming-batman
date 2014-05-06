Tickets::Application.routes.draw do
  
  root to: "tickets#index", filter: "new"
  
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
