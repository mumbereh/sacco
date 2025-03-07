class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  # GET /loans
  def index
    @loans = Loan.all.order(created_at: :desc)
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # POST /loans
  def create
    @loan = Loan.new(loan_params)
    if @loan.save
      redirect_to @loan, notice: "Loan application was successfully created."
    else
      render :new
    end
  end

  # GET /loans/:id
  def show
  end

  # GET /loans/:id/edit
  def edit
  end

  # PATCH/PUT /loans/:id
  def update
    # When attempting to set status to approved, verify that all approvals are in place.
    if loan_params[:status] == "approved"
      if @loan.loan_officer_approved? && @loan.secretary_approved? && @loan.chairperson_approved?
        if @loan.update(loan_params)
          flash[:notice] = "Loan approved and processed."
          redirect_to @loan
        else
          flash[:alert] = "Loan update failed."
          render :edit
        end
      else
        flash[:alert] = "Loan approval must go through all officers (Loan Officer, Secretary, and Chairperson)."
        render :edit
      end
    else
      if @loan.update(loan_params)
        flash[:notice] = "Loan updated successfully."
        redirect_to @loan
      else
        render :edit
      end
    end
  end

  # DELETE /loans/:id
  def destroy
    @loan.destroy
    redirect_to loans_path, notice: "Loan deleted."
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(
      :member_id,
      :loan_type,
      :amount,
      :interest_rate,
      :payment_period,
      :monthly_installment_payment,
      :total_amount_after_deduction,
      :status,
      :approval_status,
      :loan_officer_approved,
      :secretary_approved,
      :chairperson_approved,
      :date_loan_taken,
      :date_loan_end
    )
  end
end
