
class LoanRepaymentsController < ApplicationController
  before_action :set_loan_repayment, only: %i[show edit update destroy]

  # GET /loan_repayments
  def index
    @loan_repayments = LoanRepayment.all
  end

  # Show specific loan repayment details
  def show; end

  def new
    @loan_repayment = LoanRepayment.new
  end

  def create
    @loan_repayment = LoanRepayment.new(loan_repayment_params)
    
    if @loan_repayment.save
      flash[:notice] = "Repayment successfully recorded."
      redirect_to loan_path(@loan_repayment.loan)
    else
      flash[:alert] = "Error: #{@loan_repayment.errors.full_messages.join(", ")}"
      render :new
    end
  end

end
  def edit; end

  def update
    if @loan_repayment.update(loan_repayment_params)
      update_loan_repayment_status(@loan_repayment.loan)
      redirect_to loan_path(@loan_repayment.loan), notice: 'Loan repayment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    loan = @loan_repayment.loan
    @loan_repayment.destroy
    update_loan_repayment_status(loan)
    redirect_to loan_path(loan), notice: 'Loan repayment was successfully deleted.'
  end

  private

  def set_loan_repayment
    @loan_repayment = LoanRepayment.find(params[:id])
  end

  def loan_repayment_params
    params.require(:loan_repayment).permit(:loan_id, :member_id, :payment_amount, :payment_date, :note)
  end

  # Automatically update repayment status on the loan
  def update_loan_repayment_status(loan)
    if loan.outstanding_balance <= 0
      loan.update(repayment_status: "Repaid")
    else
      loan.update(repayment_status: "Ongoing")
    end
  end
