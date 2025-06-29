Rails.application.routes.draw do
  resources :member_reports
  resources :transaction_reports
  # Dashboard
  root "dashboard#index"
  get 'dashboard', to: 'dashboard#index'

  # Loan Reports
  resources :loan_reports, only: [:index]

  # Other Reports
  resources :reports do
    collection do
      get :general_report
      get :transaction_report
      get :member_report
    end
  end

  # Loan Repayments
  resources :loan_repayments

  # Members and nested resources
  resources :members do
    resources :accounts
    resources :loans
    resources :transactions
  end

  # Standalone Resources
  resources :accounts
  resources :loans do
    member do
      patch :approve
    end
  end
  resources :transactions
end
