class SavingsCommitmentsController < ApplicationController
  before_action :set_savings_commitment, only: %i[ show edit update destroy ]

  # GET /savings_commitments or /savings_commitments.json
  def index
    @savings_commitments = SavingsCommitment.all
  end

  # GET /savings_commitments/1 or /savings_commitments/1.json
  def show
  end

  # GET /savings_commitments/new
  def new
    @savings_commitment = SavingsCommitment.new
  end

  # GET /savings_commitments/1/edit
  def edit
  end

  # POST /savings_commitments or /savings_commitments.json
  def create
    @savings_commitment = SavingsCommitment.new(savings_commitment_params)

    respond_to do |format|
      if @savings_commitment.save
        format.html { redirect_to @savings_commitment, notice: "Savings commitment was successfully created." }
        format.json { render :show, status: :created, location: @savings_commitment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @savings_commitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /savings_commitments/1 or /savings_commitments/1.json
  def update
    respond_to do |format|
      if @savings_commitment.update(savings_commitment_params)
        format.html { redirect_to @savings_commitment, notice: "Savings commitment was successfully updated." }
        format.json { render :show, status: :ok, location: @savings_commitment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @savings_commitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /savings_commitments/1 or /savings_commitments/1.json
  def destroy
    @savings_commitment.destroy!

    respond_to do |format|
      format.html { redirect_to savings_commitments_path, status: :see_other, notice: "Savings commitment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_savings_commitment
      @savings_commitment = SavingsCommitment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def savings_commitment_params
      params.require(:savings_commitment).permit(:member_id, :target_amount, :monthly_contribution, :status)
    end
end
