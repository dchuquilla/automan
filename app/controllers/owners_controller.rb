class OwnersController < ApplicationController
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :set_owner, only: [:show, :edit, :update, :destroy]

  # GET /owners
  # GET /owners.json
  def index
    @owners = Owner.all
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
  end

  # GET /owners/new
  def new
    @owner = Owner.new
  end

  # GET /owners/1/edit
  def edit
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = Owner.new(owner_params)
    @owner.user_id = current_user.id
    @owner.email = current_user.email
    respond_to do |format|
      if @owner.save
        UserNotifierMailer.send_signup_email(current_user).deliver
        format.html { redirect_to @owner, notice: 'El propietario fue registrado.' }
        format.json { render :show, status: :created, location: @owner }
      else
        format.html { render :new }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owners/1
  # PATCH/PUT /owners/1.json
  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to @owner, notice: 'El propietario fue actualizado.' }
        format.json { render :show, status: :ok, location: @owner }
      else
        format.html { render :edit }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    @owner.destroy
    respond_to do |format|
      format.html { redirect_to owners_url, notice: 'El propietario fue eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_params
      params.require(:owner).permit(:name, :last_name, :cel_phone, :agreement_terms)
    end
end
