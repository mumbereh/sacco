class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.manual_recipient_account = params[:manual_recipient_account]

    # If account is not selected from the form, try to find it by member_id.
    @transaction.account ||= Account.find_by(member_id: @transaction.member_id)

    if @transaction.save
      TransactionMailer.transaction_email(@transaction).deliver_now
      redirect_to transactions_path, notice: "Transaction successfully created."
    else
      flash.now[:alert] = "Failed to create transaction. Please check the details."
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: "Transaction was successfully updated."
    else
      flash.now[:alert] = "Failed to update transaction. Please check the details."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    if @transaction.destroy
      redirect_to transactions_path, status: :see_other, notice: "Transaction was successfully destroyed."
    else
      redirect_to transactions_path, alert: "Failed to delete transaction."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to transactions_path, alert: "Transaction not found."
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:member_id, :account_id, :transaction_type, :amount, :recipient_account_id)
  end
end
