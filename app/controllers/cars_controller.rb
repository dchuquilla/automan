class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :clean_car_selection_cookie, only: [:index, :destroy]
  before_action :set_car, only: [:show, :select, :edit, :update_current_km, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.where("owner_id = ?", current_user.owner.id)
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
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
    @car.owner_id = current_user.owner.id
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.where("id = ? AND owner_id = ?", params[:id], current_user.owner.id).last
      unless @car.present?
        not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:plate, :brand, :model, :current_km, :car_type, :week_km, :owner_id, :year)
    end
end
