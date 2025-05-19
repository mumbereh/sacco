Rails.application.routes.draw do
  # Reports with custom actions
  resources :reports do
    collection do
      get :general_report
      get :transaction_report
      get :loan_report
    end

    member do
      get :member_report
    end
  end

  # Loan Repayments
  resources :loan_repayments

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Members and their related resources
  resources :members do
    member do
      get "index"  # Consider renaming this to 'show' for RESTful clarity
    end
    resources :accounts
    resources :loans
    resources :transactions
  end

  # Standalone Resources
  resources :accounts
  resources :loans do
    member do
      patch :approve, to: 'loans#approve', as: 'approve'
    end
  end
  resources :transactions

  # Root path
  root "dashboard#index"
end
