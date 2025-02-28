class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]

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
      render :new
    end
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully deleted.'
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
      :signature, :declaration_date
    )
  end
end  