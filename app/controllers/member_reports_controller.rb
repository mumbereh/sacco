class MemberReportsController < ApplicationController
  before_action :set_member_report, only: [:show, :destroy]

  def index
    @member_reports = MemberReport.includes(:member).order(created_at: :desc)
  end

  def show
    @member = @member_report.member

    if @member.present?
      @transactions = @member.transactions.order(created_at: :desc)
      @loans = @member.loans.includes(:loan_repayments)
    else
      redirect_to member_reports_path, alert: "Member not found for this report."
    end
  end

  def new
    @member_report = MemberReport.new
  end

  def create
    @member_report = MemberReport.new(member_report_params)

    if @member_report.save
      redirect_to @member_report, notice: "Member report generated successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @member_report.destroy
    redirect_to member_reports_path, notice: "Report deleted."
  end

  private

  def set_member_report
    @member_report = MemberReport.find_by(id: params[:id])
    redirect_to member_reports_path, alert: "Report not found." if @member_report.nil?
  end

  def member_report_params
    params.require(:member_report).permit(:member_id)
  end
end
