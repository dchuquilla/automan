class UserCarSettingsController < ApplicationController
  before_action :set_user_car_setting, only: [:show, :edit, :update, :destroy]

  # GET /user_car_settings
  # GET /user_car_settings.json
  def index
    @user_car_settings = UserCarSetting.all
  end

  # GET /user_car_settings/1
  # GET /user_car_settings/1.json
  def show
  end

  # GET /user_car_settings/new
  def new
    @user_car_setting = UserCarSetting.new
    @maintenance_history = MaintenanceHistory.find(params[:maintenance_history_id])
  end

  # GET /user_car_settings/1/edit
  def edit
    @maintenance_history = MaintenanceHistory.find(params[:maintenance_history_id])
  end

  # POST /user_car_settings
  # POST /user_car_settings.json
  def create
    @user_car_setting = UserCarSetting.new(user_car_setting_params)
    respond_to do |format|
      if @user_car_setting.save
        format.html { redirect_to @user_car_setting, notice: 'Configuración creada' }
        format.json { render :show, status: :created, location: @user_car_setting }
      else
        format.html { render :new }
        format.json { render json: @user_car_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_car_settings/1
  # PATCH/PUT /user_car_settings/1.json
  def update
    respond_to do |format|
      if @user_car_setting.update(user_car_setting_params)
        format.html { redirect_to car_maintenance_history_path(@car_selected, @maintenance_history), notice: 'Configuración actualizada.' }
        format.json { render :show, status: :ok, location: @user_car_setting }
      else
        format.html { render :edit }
        format.json { render json: @user_car_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_car_settings/1
  # DELETE /user_car_settings/1.json
  def destroy
    @user_car_setting.destroy
    respond_to do |format|
      format.html { redirect_to _user_car_settings_url, notice: 'Configuración eliminada' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_car_setting
      @maintenance_history = MaintenanceHistory.find(params[:maintenance_history_id])
      @user_car_setting = UserCarSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_car_setting_params
      params.require(:user_car_setting).permit(:km_estimated, :month_estimated)
    end
end
