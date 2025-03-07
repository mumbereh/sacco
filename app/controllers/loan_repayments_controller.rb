class LoanRepaymentsController < ApplicationController
  before_action :set_loan_repayment, only: %i[show edit update destroy]

  # Display all loan repayments
  def index
    @loan_repayments = LoanRepayment.all
  end

  # Show specific loan repayment details
  def show
  end

  # Other actions (new, create, edit, update, destroy)
  def new
    @loan_repayment = LoanRepayment.new
  end

  def create
    @loan_repayment = LoanRepayment.new(loan_repayment_params)
    if @loan_repayment.save
      redirect_to loan_repayments_path, notice: 'Loan repayment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @loan_repayment.update(loan_repayment_params)
      redirect_to @loan_repayment, notice: 'Loan repayment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @loan_repayment.destroy
    redirect_to loan_repayments_url, notice: 'Loan repayment was successfully destroyed.'
  end

  private

  def set_loan_repayment
    @loan_repayment = LoanRepayment.find(params[:id])
  end

  def loan_repayment_params
    params.require(:loan_repayment).permit(:loan_id, :member_id, :payment_amount, :payment_date, :note)
  end
end
