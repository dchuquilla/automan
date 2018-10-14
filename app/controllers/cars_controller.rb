class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :clean_car_selection_cookie, only: [:index, :destroy]
  before_action :set_car, only: [:show, :select, :edit, :update_current_km, :update, :destroy, :image_detach]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.where("owner_id = ?", current_user.owner.id)
  end

  def brands
    q_term = "#{params[:q]}"
    brands = Car.distinct.select('brand').where("brand ~* ?", q_term).map(&:brand)
    respond_to do |format|
      format.json { render json: brands.to_json }
      format.html { render text: "no aplica"}
    end
  end

  def models
    q_term = "#{params[:q]}"
    models = Car.distinct.select('model').where("model ~* ?", q_term).map(&:model)
    respond_to do |format|
      format.json { render json: models.to_json }
      format.html { render text: "no aplica"}
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    cookies[:selected_car_id] = @car.id
    set_car_with_cookies
  end

  # GET /cars/1
  # GET /cars/1.json
  def select
    cookies[:selected_car_id] = @car.id
    redirect_to maintenance_histories_path
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
        format.html { redirect_to @car, notice: 'Su auto fue creado.' }
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
        format.html { redirect_to @car, notice: 'Su auto fue actualizado.' }
        format.json { render :show, status: :ok, location: @car }
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
      params.require(:car).permit(:plate, :brand, :model, :current_km, :car_type, :week_km, :owner_id, :year, :km_updated_date)
    end
end
