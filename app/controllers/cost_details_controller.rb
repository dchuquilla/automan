class CostDetailsController < ApplicationController
  before_action :set_cost_detail, only: [:show, :edit, :update, :destroy]

  # GET /cost_details
  # GET /cost_details.json
  def index
    @cost_details = CostDetail.all
  end

  # GET /cost_details/1
  # GET /cost_details/1.json
  def show
  end

  # GET /cost_details/new
  def new
    @cost_detail = CostDetail.new
  end

  # GET /cost_details/1/edit
  def edit
  end

  # POST /cost_details
  # POST /cost_details.json
  def create
    @cost_detail = CostDetail.new(cost_detail_params)

    respond_to do |format|
      if @cost_detail.save
        format.html { redirect_to @cost_detail, notice: 'Cost detail was successfully created.' }
        format.json { render :show, status: :created, location: @cost_detail }
      else
        format.html { render :new }
        format.json { render json: @cost_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cost_details/1
  # PATCH/PUT /cost_details/1.json
  def update
    respond_to do |format|
      if @cost_detail.update(cost_detail_params)
        format.html { redirect_to @cost_detail, notice: 'Cost detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @cost_detail }
      else
        format.html { render :edit }
        format.json { render json: @cost_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cost_details/1
  # DELETE /cost_details/1.json
  def destroy
    @cost_detail.destroy
    respond_to do |format|
      format.html { redirect_to cost_details_url, notice: 'Cost detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost_detail
      @cost_detail = CostDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cost_detail_params
      params.require(:cost_detail).permit(:cost_type, :cost, :provider, :maintenance_history_id)
    end
end
