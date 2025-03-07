class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    Rails.logger.debug "Account Params: #{account_params}" # Debugging

    if @account.save
      redirect_to @account, notice: "Account was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    if @account.update(account_params)
      redirect_to @account, notice: "Account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    redirect_to accounts_path, status: :see_other, notice: "Account was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find_by(id: params[:id])
    return if @account

    redirect_to accounts_path, alert: "Account not found."
  end

  # Allow only the required parameters for account creation and updating.
  def account_params
    params.require(:account).permit(:member_id, :account_type, :balance, :principal_amount, :deposit, :account_number)
  end
end