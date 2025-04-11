class MemberMailer < ApplicationMailer
  helper ActionView::Helpers::NumberHelper  # Include currency formatting helper

  # Method to send the loan status update email
  def loan_status_updated(member, loan)
    @member = member
    @loan = loan

    # Send the email with the provided details
    mail(
      to: @member.email, 
      subject: "Your Loan Status Has Been Approved",
      content_type: "text/html"
    ) do |format|
      format.html { render "member_mailer/loan_status_updated" }
    end
  end
end
