class TransactionReportsController < ApplicationController
  before_action :set_transaction_report, only: [:show, :edit, :update, :destroy]

  def index
    @transaction_reports = TransactionReport.all.order(created_at: :desc)
    @transactions = Transaction.includes(:member, :account, :recipient_account).order(created_at: :desc)
  end

  def new
    @transaction_report = TransactionReport.new
  end

  def create
    @transaction_report = TransactionReport.new(transaction_report_params)
    if @transaction_report.save
      redirect_to @transaction_report, notice: "Transaction Report was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @transactions = @transaction_report.transactions
  end

  def destroy
    @transaction_report.destroy
    redirect_to transaction_reports_path, notice: "Transaction Report was successfully deleted."
  end

  private

  def set_transaction_report
    @transaction_report = TransactionReport.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to transaction_reports_path, alert: "Transaction Report not found."
  end

  def transaction_report_params
    params.require(:transaction_report).permit(:from, :to)
  end
end
