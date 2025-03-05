class LoansController < ApplicationController
  before_action :set_loan, only: %i[show edit update destroy]

  # Display all loans
  def index
    @loans = Loan.all
  end

  # Show details of a specific loan
  def show
  end

  # Initialize a new loan instance
  def new
    @loan = Loan.new
  end

  # Load an existing loan for editing
  def edit
  end

  # Create a new loan and save it to the database
  def create
    @loan = Loan.new(loan_params)
    calculate_loan_details # Ensure calculated values are assigned

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: "Loan was successfully created." }
        format.json { render :show, status: :created, location: @loan }
      else
        # Log error messages for better debugging
        Rails.logger.error("Loan creation failed: #{@loan.errors.full_messages.join(', ')}")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update an existing loan
  def update
    @loan.assign_attributes(loan_params)
    calculate_loan_details # Recalculate totals before saving

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: "Loan was successfully updated." }
        format.json { render :show, status: :ok, location: @loan }
      else
        # Log validation errors for debugging
        Rails.logger.error("Loan update failed: #{@loan.errors.full_messages.join(', ')}")
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete a loan record
  def destroy
    if @loan.destroy
      respond_to do |format|
        format.html { redirect_to loans_path, status: :see_other, notice: "Loan was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      Rails.logger.error("Loan deletion failed")
      redirect_to loans_path, alert: "Error deleting loan."
    end
  end

  private

  # Find the loan by ID before performing actions
  def set_loan
    @loan = Loan.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to loans_path, alert: "Loan not found."
  end

  # Permit only allowed parameters for security
  def loan_params
    params.require(:loan).permit(
      :member_id, :loan_type, :amount, :interest_rate, 
      :payment_period, :monthly_installment_payment, 
      :total_amount_after_deduction, :date_loan_taken, 
      :date_loan_end, 
      :guarantor1_name, :guarantor1_nin, :guarantor1_phone, 
      :guarantor1_village, :guarantor1_parish, :guarantor1_subcounty, 
      :guarantor2_name, :guarantor2_nin, :guarantor2_phone, 
      :guarantor2_village, :guarantor2_parish, :guarantor2_subcounty, 
      :guarantor3_name, :guarantor3_nin, :guarantor3_phone, 
      :guarantor3_village, :guarantor3_parish, :guarantor3_subcounty
    )
  end

  # Compute monthly payments and total amount with interest
  def calculate_loan_details
    return unless @loan.payment_period.present? && @loan.amount.present? && @loan.interest_rate.present?

    interest_amount = (@loan.amount * @loan.interest_rate * @loan.payment_period) / 100
    total_amount = @loan.amount + interest_amount
    monthly_payment = total_amount / @loan.payment_period

    @loan.total_amount_after_deduction = total_amount
    @loan.monthly_installment_payment = monthly_payment
  end
end
