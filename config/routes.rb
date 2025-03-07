Rails.application.routes.draw do
  resources :loan_repayments
  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Members and their related resources
  
  resources :members do
    member do
      get "index"  # Individual member profile
    end
    resources :accounts
    resources :loans
    resources :transactions
  end

  # Standalone resources
  resources :accounts
  resources :loans
  resources :transactions
  # Root path
  root "dashboard#index"
end
