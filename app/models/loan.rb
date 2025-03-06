<%= form_with(model: loan) do |form| %>
  <% if loan.errors.any? %>
    <div style="color: red">
      <h2><%= pluralize(loan.errors.count, "error") %> prohibited this loan from being saved:</h2>
      <ul>
        <% loan.errors.each do |error| %>
          <li><%= error.full_message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <h2 class="details">Loan Application</h2>

  <div>
    <%= form.label :client, "Select Member", style: "display: block" %>
    <%= form.collection_select :member_id, Member.all, :id, :name, prompt: "Select Member", class: "form-control", required: true %>
  </div>

  <div>
    <%= form.label :loan_type, "Loan Type", style: "display: block" %>
    <%= form.select :loan_type, ["Business Loan", "School Loan", "Land/House Purchase", "Salary Loan", "Emergency Loan", "Others"], { prompt: "Select Loan Type" }, class: "form-control", required: true %>
  </div>

  <div>
    <%= form.label :amount, "Loan Amount", style: "display: block" %>
    <%= form.number_field :amount, step: 0.01, class: "form-control", id: "loan_amount", required: true %>
  </div>

  <div>
    <%= form.label :interest_rate, "Interest Rate (%)", style: "display: block" %>
    <%= form.number_field :interest_rate, step: 0.01, class: "form-control", id: "loan_interest_rate", value: 3, readonly: true %>
  </div>

  <div>
    <%= form.label :payment_period, "Payment Period (Months)", style: "display: block" %>
    <%= form.number_field :payment_period, class: "form-control", id: "loan_payment_period", min: 1, required: true %>
  </div>

  <div>
    <%= form.label :monthly_installment_payment, "Monthly Installment Payment", style: "display: block" %>
    <%= form.number_field :monthly_installment_payment, step: 0.01, class: "form-control", readonly: true, id: "monthly_installment_payment" %>
  </div>

  <div>
    <%= form.label :total_amount_after_deduction, "Total Amount After Deduction", style: "display: block" %>
    <%= form.number_field :total_amount_after_deduction, step: 0.01, class: "form-control", readonly: true, id: "total_amount_after_deduction" %>
  </div>

  <div>
    <%= form.label :status, "Loan Status", style: "display: block" %>
    <%= form.select :status, ["pending", "processing", "approved", "rejected", "repaid"], {}, class: "form-control", required: true %>
  </div>

  <div>
    <%= form.label :approval_status, "Approval Status", style: "display: block" %>
    <%= form.select :approval_status, Loan.approval_statuses.keys.map { |s| [s.humanize, s] }, {}, class: "form-control", required: true %>
  </div>

  <div>
    <%= form.label :loan_officer_approval, "Loan Officer Approval", style: "display: block" %>
    <%= form.check_box :loan_officer_approved, {}, true, false %>
  </div>

  <div>
    <%= form.label :secretary_approval, "Secretary Approval", style: "display: block" %>
    <%= form.check_box :secretary_approved, { disabled: !loan.loan_officer_approved? }, true, false %>
  </div>

  <div>
    <%= form.label :chairperson_approval, "Chairperson Approval", style: "display: block" %>
    <%= form.check_box :chairperson_approved, { disabled: !loan.secretary_approved? }, true, false %>
  </div>

  <div>
    <%= form.label :date_loan_taken, "Date Loan Taken", style: "display: block" %>
    <%= form.date_field :date_loan_taken, class: "form-control", required: true %>
  </div>

  <div>
    <%= form.label :date_loan_end, "Date Loan Ends", style: "display: block" %>
    <%= form.date_field :date_loan_end, class: "form-control", required: true %>
  </div>

  <div>
    <%= form.submit "Apply for Loan", class: "btn btn-primary", id: "submit-btn" %>
  </div>
<% end %>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const loanAmount = document.getElementById('loan_amount');
    const interestRate = 3; // Fixed interest rate
    const paymentPeriod = document.getElementById('loan_payment_period');
    const monthlyInstallmentPayment = document.getElementById('monthly_installment_payment');
    const totalAmountAfterDeduction = document.getElementById('total_amount_after_deduction');
    const submitBtn = document.getElementById('submit-btn');

    function calculateLoanDetails() {
      const amount = parseFloat(loanAmount.value);
      const period = parseInt(paymentPeriod.value);

      if (amount && period) {
        const interestAmount = (amount * interestRate / 100.0) * (period / 12.0);
        const totalAmount = amount + interestAmount;
        totalAmountAfterDeduction.value = totalAmount.toFixed(2);

        const monthlyInstallment = totalAmount / period;
        monthlyInstallmentPayment.value = monthlyInstallment.toFixed(2);
      } else {
        totalAmountAfterDeduction.value = '';
        monthlyInstallmentPayment.value = '';
      }
      validateForm();
    }

    function validateForm() {
      submitBtn.disabled = !(loanAmount.value && paymentPeriod.value);
    }

    loanAmount.addEventListener('input', calculateLoanDetails);
    paymentPeriod.addEventListener('input', calculateLoanDetails);
  });
</script>
