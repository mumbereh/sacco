class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members
  def index
    @members = Member.all
  end

  # GET /members/1
  def show
    @member = Member.find(params[:id])
  end
  

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy!
    respond_to do |format|
      format.html { redirect_to members_path, status: :see_other, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(
      :membership_type, :surname, :given_name, :other_name, :date_of_birth, :gender, 
      :marital_status, :physical_address, :phone, :identification_type, 
      :id_number, :mother_name, :mother_nationality, :father_name, :father_nationality, 
      :kin_surname, :kin_given_name, :kin_other_name, :kin_date_of_birth, :kin_gender, 
      :kin_relationship, :kin_phone, :kin_address, :declaration_name, :signature, :declaration_date
    )
  end
end
