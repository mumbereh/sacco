class LoanMailer < ApplicationMailer
    default from: 'no-reply@saccoapp.com'
  
    def loan_fully_approved_email(loan)
      @loan = loan
      @member = loan.member
      mail(to: @member.email, subject: 'Loan Fully Approved')
    end
  end
  