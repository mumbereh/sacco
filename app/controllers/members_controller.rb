class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy details]

  def index
    @members = Member.all
  end

  def show
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member, notice: 'Member was successfully created.'
    else
      flash.now[:alert] = "Member creation failed: #{@member.errors.full_messages.join(', ')}"
      Rails.logger.error("Member creation failed: #{@member.errors.full_messages.join(', ')}")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      flash.now[:alert] = "Member update failed: #{@member.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully deleted.'
  end

  def details
    savings_commitment = @member.savings_commitments.last
    render json: {
      surname: @member.surname,
      given_name: @member.given_name,
      other_name: @member.other_name,
      full_name: @member.name,
      date_of_birth: @member.date_of_birth,
      phone: @member.phone,
      id_number: @member.id_number,
      membership_type: @member.membership_type,
      marital_status: @member.marital_status,
      physical_address: @member.physical_address,
      gender: @member.gender,
      identification_type: @member.identification_type,
      mother_name: @member.mother_name,
      mother_nationality: @member.mother_nationality,
      father_name: @member.father_name,
      father_nationality: @member.father_nationality,
      kin_surname: @member.kin_surname,
      kin_given_name: @member.kin_given_name,
      kin_other_name: @member.kin_other_name,
      kin_date_of_birth: @member.kin_date_of_birth,
      kin_gender: @member.kin_gender,
      kin_relationship: @member.kin_relationship,
      kin_phone: @member.kin_phone,
      kin_address: @member.kin_address,
      declaration_name: @member.declaration_name,
      declaration_date: @member.declaration_date,
      target_amount: savings_commitment&.target_amount,
      total_contributed: savings_commitment&.total_contributed,
      savings_progress: savings_commitment ? savings_commitment.progress : 0
    }
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(
      :membership_type, :surname, :given_name, :other_name, :date_of_birth, :gender, 
      :marital_status, :physical_address, :phone, :passport_photo, :identification_type, 
      :id_number, :id_document_photo, :mother_name, :mother_nationality, :father_name, 
      :father_nationality, :kin_surname, :kin_given_name, :kin_other_name, :kin_date_of_birth, 
      :kin_gender, :kin_relationship, :kin_phone, :kin_address, :declaration_name, 
      :signature, :declaration_date, :email
    )
  end
end  