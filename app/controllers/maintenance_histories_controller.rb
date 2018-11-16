class MaintenanceHistoriesController < ApplicationController
  
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :maintenance_status
  before_action :set_maintenance_history, only: [:show, :edit, :review, :update, :destroy, :image_detach, :last_maintenance_dates]
  before_action :set_car_with_cookies

  # GET /maintenance_histories
  # GET /maintenance_histories.json
  def index
    if params[:filtro]
      @maintenance_histories = MaintenanceHistory.where("car_id = ? AND maintenance_type <> 'Carga de gasolina'", @car_selected.id).where("status = ?", params[:filtro]).order("priority, review_date DESC")
    else
      @maintenance_histories = MaintenanceHistory.where("car_id = ? AND status <> 'Completado'", @car_selected.id).order("priority, scheduled_date ASC")
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
    car = Car.find params[:car_id]
    @maintenance_history.estimated_km = car.current_km
  end

  # GET /maintenance_histories/1/edit
  def edit
  end

  def last_maintenance_dates
    maintenance_types = ["Cambio de aceite y filtros", "Inspección de frenos", "ABC de Motor", "Cambiar Aceite de Caja", "Cambar Filtro de Combustible"]
    @maintenance_histories = MaintenanceHistory.where("car_id = ? AND maintenance_type in (?)", @car_selected.id, maintenance_types).where("status = 'Pendiente'").order("priority, review_date DESC")
  end

  # GET /maintenance_histories/1/review
  def review
    if @maintenance_history.nil?
      @maintenance_history = MaintenanceHistory.new
      car = @car_selected
    else
      car = @maintenance_history.car
    end
    @maintenance_history.status = "Completado"
    @maintenance_history.estimated_km = car.current_km
    @maintenance_history.scheduled_date = DateTime.now.strftime(DATE_FORMAT)
    @maintenance_history.review_km = car.current_km
    @maintenance_history.review_date = DateTime.now.strftime(DATE_FORMAT)
  end

  # GET /maintenance_histories/1/review
  def gas
    if @maintenance_history.nil?
      @maintenance_history = MaintenanceHistory.new
      car = @car_selected
    else
      car = @maintenance_history.car
    end
    @maintenance_history.maintenance_type = "Carga de gasolina"
    @maintenance_history.status = "Completado"
    @maintenance_history.estimated_km = car.current_km
    @maintenance_history.scheduled_date = DateTime.now.strftime(DATE_FORMAT)
    @maintenance_history.review_km = car.current_km
    @maintenance_history.review_date = DateTime.now.strftime(DATE_FORMAT)
  end

  # POST /maintenance_histories
  # POST /maintenance_histories.json
  def create
    @maintenance_history = MaintenanceHistory.new(maintenance_history_params)
    @maintenance_history.car_id = @car_selected.id
    if params[:maintenance_history][:images]
      @maintenance_history.images.attach(params[:maintenance_history][:images])
    end
    respond_to do |format|
      if @maintenance_history.save
        format.html { redirect_to car_maintenance_histories_url(@car_selected), notice: 'El mantenimiento fue creado.' }
        format.json { render :show, status: :created, location: @maintenance_history }
      else
        if params[:from_gas].present?
          format.html { render :gas }
        elsif params[:from_review].present?
          format.html { render :review }
        else
          format.html { render :new }
        end
        format.json { render json: @maintenance_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_histories/1
  # PATCH/PUT /maintenance_histories/1.json
  def update
    @maintenance_history.car_id = @car_selected.id
    if params[:maintenance_history][:images]
      @maintenance_history.images.attach(params[:maintenance_history][:images])
    end
    respond_to do |format|
      if @maintenance_history.update(maintenance_history_params)
        format.html { redirect_to car_maintenance_histories_url(@car_selected), notice: 'El mantenimiento fue modificado.' }
        format.json { render :show, status: :ok, location: @maintenance_history }
      else
        if params[:from_gas].present?
          format.html { render :gas }
        elsif params[:from_review].present?
          format.html { render :review }
        else
          format.html { render :edit }
        end
        format.json { render json: @maintenance_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_histories/1
  # DELETE /maintenance_histories/1.json
  def destroy
    @maintenance_history.destroy
    respond_to do |format|
      format.html { redirect_to car_maintenance_histories_url(@car_selected), notice: 'El mantenimiento fue eliminado.' }
      format.json { head :no_content }
    end
  end

  def image_detach
    image = @maintenance_history.images.where(id: params[:image_id]).first
    image.purge_later
    respond_to do |format|
      format.html { redirect_to action: 'show' }
      format.json { render text: "Imagen eliminada."}
    end
  end

  def maintenance_status
    @maintenance_status = ["Pendiente", "Completado", "Expirado"]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_history
      begin
        @maintenance_history = MaintenanceHistory.find(params[:id])
      rescue Exception => e
        @maintenance_history = nil
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_history_params
      params.require(:maintenance_history).permit(:status, :estimated_km, :scheduled_date, :review_km, :review_date, :provider, :cost, :notified, :maintenance_type, :gallons)
    end
end
