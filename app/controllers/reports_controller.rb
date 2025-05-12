class ReportsController < ApplicationController
  def index
    @estates = Estate.all  # Ensure @estates is loaded with all Estate records
    @tenants = Tenant.includes(:leases, :payments, :room, room: [:estate, :room_type])

    # Apply filters based on parameters if present
    filter_by_tenant_name if params[:name].present?
    filter_by_estate_name if params[:estate_name].present?
    filter_by_payment_status if params[:paid].present?
  end

  def tenant_report
    @tenant = Tenant.find(params[:tenant_id])
    @leases = @tenant.leases.includes(:payments, :room, room: [:estate, :room_type])
    @payments = @leases.flat_map(&:payments)
  end

  def estate_report
    @estates = Estate.includes(rooms: { tenants: { leases: :payments } })

    @estate_reports = @estates.map do |estate|
      monthly_data = generate_monthly_data(estate)
      { estate: estate, monthly_data: monthly_data }
    end
  end

  private

  # Filters tenants by first or last name
  def filter_by_tenant_name
    # Ensure the tenant name filter includes the estate data and only selects tenants belonging to estates
    @tenants = @tenants.joins(room: :estate)
                       .where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%")
                       .distinct

    # If a tenant name is provided, filter estates to only those that have matching tenants
    @estates = Estate.joins(rooms: :tenants)
                     .where(tenants: { id: @tenants.pluck(:id) })
  end

  # Filters tenants by estate name
  def filter_by_estate_name
    # Ensure that only tenants belonging to the selected estate are shown
    @tenants = @tenants.joins(room: :estate)
                       .where("estates.name ILIKE ?", "%#{params[:estate_name]}%")
                       .distinct

    # Filter estates to only show those that have tenants matching the given estate name
    @estates = Estate.where("name ILIKE ?", "%#{params[:estate_name]}%")
  end

  # Filters tenants by payment status for the current month
  def filter_by_payment_status
    current_month = Date.today.beginning_of_month..Date.today.end_of_month
    paid_tenant_ids = Payment.where(payment_date: current_month).pluck(:tenant_id).uniq

    case params[:paid]
    when 'true'
      # Only select tenants who have paid this month
      @tenants = @tenants.where(id: paid_tenant_ids)
    when 'false'
      # Only select tenants who have not paid this month
      @tenants = @tenants.where.not(id: paid_tenant_ids)
    end
  end

  # Generates monthly data for each estate in the estate report
  def generate_monthly_data(estate)
    monthly_data = {}

    estate.rooms.each do |room|
      room.tenants.each do |tenant|
        tenant.leases.each do |lease|
          lease.payments.each do |payment|
            month = payment.payment_date.strftime("%B %Y")
            monthly_data[month] ||= { collected: 0, outstanding: 0 }
            monthly_data[month][:collected] += payment.amount

            monthly_due = lease.monthly_rent
            monthly_data[month][:outstanding] += (monthly_due - payment.amount) if payment.amount < monthly_due
          end
        end
      end
    end
    monthly_data
  end
end
