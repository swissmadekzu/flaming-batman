Tickets::Application.routes.draw do
  
  root to: "tickets#index", filter: "new"
  
  resources :tickets do
    collection do
      get 'tech'
    end

    member do
      post "treat"
      post "end_treatment"
      post "validate_solution"
      post "reopen_ticket"
    end
  end
  resources :messages
  resources :attachments
  
  get 'supervisor' => "supervisor#index", as: :supervisor_dashboard
  get 'supervisor/:id' => "supervisor#supervise", as: :supervise_ticket
  get 'supervisor/:id/logs' => "supervisor#logentries", as: :supervise_logs

  get 'api/tickets/new' => "api/tickets#new"
  get 'api/tickets/open' => "api/tickets#open"
  
end
