Rails.application.routes.draw do
  # Loan Repayments
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
  resources :loans do
    # Define a custom route for loan approval actions
    member do
      patch :approve, to: 'loans#approve', as: 'approve'
    end
  end
  resources :transactions

  # Root path
  root "dashboard#index"
end
