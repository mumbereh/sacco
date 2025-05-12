class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    @transactions = Transaction.includes(:account, :member).order(created_at: :desc)
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def edit; end

  def create
    @transaction = Transaction.new(transaction_params)

    # Assign a default account if not selected
    if @transaction.account_id.blank? && @transaction.member_id.present?
      @transaction.account = Account.find_by(member_id: @transaction.member_id)
    end

    if @transaction.save
      redirect_to transactions_path, notice: "Transaction successfully created."
    else
      flash.now[:alert] = "Failed to create transaction. Please check the details."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: "Transaction was successfully updated."
    else
      flash.now[:alert] = "Failed to update transaction. Please check the details."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @transaction.destroy
      redirect_to transactions_path, status: :see_other, notice: "Transaction was successfully destroyed."
    else
      redirect_to transactions_path, alert: "Failed to delete transaction."
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to transactions_path, alert: "Transaction not found."
  end

  def transaction_params
    params.require(:transaction).permit(
      :member_id, :account_id, :transaction_type, :amount,
      :recipient_account_id, :manual_recipient_account
    )
  end
end
