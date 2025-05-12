every 1.day, at: '12:00 am' do
    runner "CheckLoanPenaltiesJob.perform_later"
  end
  