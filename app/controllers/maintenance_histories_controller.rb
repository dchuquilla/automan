class MaintenanceHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :maintenance_status
  before_action :set_maintenance_history, only: [:show, :edit, :review, :update, :destroy]

  # GET /maintenance_histories
  # GET /maintenance_histories.json
  def index
    if params[:filtro]
      @maintenance_histories = MaintenanceHistory.where("car_id = ?", @car_selected.id).where("status = ?", params[:filtro]).order("scheduled_date ASC")
    else
      @maintenance_histories = MaintenanceHistory.where("car_id = ?", @car_selected.id).order("scheduled_date ASC")
    end
  end

  def types
    q_term = "#{params[:q]}"
    types = MaintenanceHistory.distinct.select('maintenance_type').where("maintenance_type ~* ?", q_term).map(&:maintenance_type)
    respond_to do |format|
      format.json { render json: types.to_json }
      format.html { render text: "no aplica"}
    end
  end

  # GET /maintenance_histories/1
  # GET /maintenance_histories/1.json
  def show
  end

  # GET /maintenance_histories/new
  def new
    @maintenance_history = MaintenanceHistory.new
  end

  # GET /maintenance_histories/1/edit
  def edit
  end

  # GET /maintenance_histories/1/review
  def review
  end

  # POST /maintenance_histories
  # POST /maintenance_histories.json
  def create
    @maintenance_history = MaintenanceHistory.new(maintenance_history_params)
    @maintenance_history.car_id = @car_selected.id
    respond_to do |format|
      if @maintenance_history.save
        format.html { redirect_to @maintenance_history, notice: 'Maintenance history was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_history }
      else
        format.html { render :new }
        format.json { render json: @maintenance_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_histories/1
  # PATCH/PUT /maintenance_histories/1.json
  def update
    @maintenance_history.car_id = @car_selected.id
    respond_to do |format|
      if @maintenance_history.update(maintenance_history_params)
        format.html { redirect_to @maintenance_history, notice: 'Maintenance history was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_history }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_histories/1
  # DELETE /maintenance_histories/1.json
  def destroy
    @maintenance_history.destroy
    respond_to do |format|
      format.html { redirect_to maintenance_histories_url, notice: 'Maintenance history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def maintenance_status
    @maintenance_status = ["Pendiente", "Completado", "Expirado"]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_history
      @maintenance_history = MaintenanceHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_history_params
      params.require(:maintenance_history).permit(:status, :estimated_km, :scheduled_date, :review_km, :review_date, :provider, :cost, :notified, :maintenance_type)
    end
end
