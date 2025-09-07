class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :approve]

  def index
    @loans = Loan.order(created_at: :desc)
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.new(loan_params)
    if @loan.save
      begin
        LoanMailer.loan_created_email(@loan).deliver_now
      rescue => e
        Rails.logger.error("LoanMailer error: #{e.message}")
        flash[:alert] = "Loan was created, but failed to send email."
      end
      redirect_to @loan, notice: "Loan application was successfully created and email sent."
    else
      render :new
    end
  end

  def approve
    officer = params[:officer].to_sym

    case officer
    when :loan_officer
      if @loan.loan_officer_approved?
        flash[:alert] = "Loan Officer has already approved this loan."
      else
        approve_and_notify(:loan_officer_approved, "Loan Officer")
      end

    when :secretary
      if !@loan.loan_officer_approved?
        flash[:alert] = "Loan must be approved by Loan Officer first."
      elsif @loan.secretary_approved?
        flash[:alert] = "Secretary has already approved this loan."
      else
        approve_and_notify(:secretary_approved, "Secretary")
      end

    when :chairperson
      if !@loan.secretary_approved?
        flash[:alert] = "Secretary must approve the loan first."
      elsif @loan.chairperson_approved?
        flash[:alert] = "Chairperson has already approved this loan."
      else
        approve_and_notify(:chairperson_approved, "Chairperson")
        finalize_approval if @loan.loan_officer_approved? && @loan.secretary_approved?
      end

    else
      flash[:alert] = "Invalid approval stage."
    end

    redirect_to loan_path(@loan)
  end

  def show; end

  def edit; end

  def update
    if loan_params[:status] == "approved"
      if @loan.loan_officer_approved? && @loan.secretary_approved? && @loan.chairperson_approved?
        update_loan("Loan approved and processed.")
      else
        flash[:alert] = "Loan approval must go through all officers."
        render :edit
      end
    else
      update_loan("Loan updated successfully.")
    end
  end

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

  def approve_and_notify(attribute, role)
    @loan.update(attribute => true, approval_status: role.downcase)
    @loan.send_notification
    LoanMailer.loan_approved_email(@loan, role).deliver_now
    flash[:notice] = "Loan approved by #{role} and email sent."
  end

  def finalize_approval
    if @loan.chairperson_approved?
      @loan.update(status: "approved", approval_status: "fully_approved")
      @loan.send_notification
      LoanMailer.loan_fully_approved_email(@loan).deliver_now
      flash[:notice] = "Loan fully approved. Final approval email sent."
    end
  end

  def update_loan(success_message)
    if @loan.update(loan_params)
      flash[:notice] = success_message
      redirect_to @loan
    else
      flash[:alert] = "Loan update failed."
      render :edit
    end
  end
end
