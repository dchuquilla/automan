class CarsController < ApplicationController
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :set_car, only: [:show, :select, :dashboard, :reports, :gas_consume, :edit, :update_current_km, :update, :destroy, :image_detach, :last_maintenance_dates]
  before_action :clean_car_selection_cookie, only: [:index, :destroy]
  before_action :set_car_selection_cookie, only: [:show, :select, :dashboard, :reports, :gas_consume]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.where("owner_id = ?", current_user.owner.id)
  end

  def brands
    q_term = "#{params[:q]}"
    brands_list = Car.get_brands_list
    brands = brands_list.select {|x| x.downcase.include?(q_term)}
    # brands = Car.distinct.select('brand').where("brand ~* ?", q_term).map(&:brand)
    respond_to do |format|
      format.json { render json: brands.to_json }
      format.html { render text: "no aplica"}
    end
  end

  def models
    q_term = "#{params[:q]}"
    brand = "#{params[:brand]}"
    models_list = Car.get_models_list[brand]
    models = models_list.select {|x| x.downcase.include?(q_term)}
    # models = Car.distinct.select('model').where("model ~* ?", q_term).map(&:model)
    respond_to do |format|
      format.json { render json: models.to_json }
      format.html { render text: "no aplica"}
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    set_car_with_cookies
  end

  # GET /cars/1
  # GET /cars/1.json
  def select
    redirect_to car_maintenance_histories_path(@car)
  end

  # GET /cars/1/dashboard
  # GET /cars/1/dashboard.json
  def dashboard
    set_car_with_cookies
  end

  # GET /cars/1/reports
  # GET /cars/1/reports.json
  def reports
    set_car_with_cookies
    @maintenance_histories = MaintenanceHistory.where("car_id = ? AND maintenance_type <> 'Carga de gasolina' AND status = 'Completado'", @car.id).order("review_date ASC")
    @maintenance_histories_gas = MaintenanceHistory.where("car_id = ? AND maintenance_type = 'Carga de gasolina' AND status = 'Completado'", @car.id).order("review_date ASC")
  end

  # GET /cars/1
  # GET /cars/1.json
  def gas_consume
    set_car_with_cookies
    @maintenance_histories = MaintenanceHistory.where("car_id = ? AND maintenance_type = 'Carga de gasolina' AND status = 'Completado'", @car.id).order("review_date ASC")
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # GET /cars/1/edit
  def update_current_km
  end

  # GET /cars/1/edit
  def update_current_kms
    # @cars = Car.where("owner_id = ?", current_user.owner.id)
    @cars = current_user.owner.cars.to_a.select {|c| ((Time.now - c.updated_at)/1.day).round >= 1}
  end

  # GET /cars/1/save_all
  def dismiss_car_update
    current_owner = current_user.owner
    current_owner.dismiss_car_updates = true;
    current_owner.agreement_terms = true;
    current_owner.save!
    redirect_to cars_path
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    @car.plate = @car.plate.upcase
    @car.owner_id = current_user.owner.id
    if params[:car][:images]
      @car.images.attach(params[:car][:images])
    end
    respond_to do |format|
      if @car.save
        format.html { redirect_to last_maintenance_dates_car_maintenance_histories_path(@car), notice: 'Su auto fue creado.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    if params[:car][:current_km].to_d > @car.current_km
      params[:car][:km_updated_date] = DateTime.now
    end
    if params[:car][:images]
      @car.images.attach(params[:car][:images])
    end
    respond_to do |format|
      if @car.update(car_params)
        if params[:stay].present? && params[:stay] == "true"
          delayed_cars = current_user.owner.cars.to_a.select {|c| ((Time.now - c.updated_at)/1.day).round >= 1}.length
          if delayed_cars == 0
            format.html { redirect_to cars_path, notice: 'Todos los kilometrajes fueron actualizados.' }
            format.json { render :show, status: :ok, location: @car }
          else
            format.html { redirect_to update_current_kms_cars_path, notice: 'Su kilometraje fue actualizado.' }
            format.json { render :show, status: :ok, location: @car }
          end
        else
          format.html { redirect_to cars_path, notice: 'Su auto fue actualizado.' }
          format.json { render :show, status: :ok, location: @car }
        end
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Su auto fue eliminado.' }
      format.json { head :no_content }
    end
  end

  def image_detach
    image = @car.images.where(id: params[:image_id]).first
    image.purge_later
    respond_to do |format|
      format.html { redirect_to action: 'show' }
      format.json { render text: "Imagen eliminada."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.where("id = ? AND owner_id = ?", params[:id], current_user.owner.id).with_attached_images.last
      unless @car.present?
        not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:plate, :brand, :model, :current_km, :car_type, :week_km, :owner_id, :year, :km_updated_date, :insurance_month, :insurance_year, :insurance_company)
    end
end
