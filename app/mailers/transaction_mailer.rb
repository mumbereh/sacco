class TransactionMailer < ApplicationMailer
    default from: 'noreply@example.com'  # Update this to your preferred sender email
  
    def transaction_email(transaction)
      @transaction = transaction
      @member = transaction.member
      mail(to: @member.email, subject: "Your #{transaction.transaction_type.capitalize} Transaction Receipt")
    end
  end