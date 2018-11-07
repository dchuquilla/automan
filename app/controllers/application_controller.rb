class ApplicationController < ActionController::Base
  before_action :set_car_with_cookies
  before_action :general_redirections

  def set_car_with_cookies
    Rails.logger.info "ApplicationController#set_car_with_cookies"
    @car_selected = nil
    if current_user.present? && (cookies[:selected_car_id].present? || params[:car_id].present?)
      if cookies[:selected_car_id].present?
        @car_selected = Car.where("id = ? AND owner_id = ?", cookies[:selected_car_id], current_user.owner.id).last
      elsif params[:car_id].present?
        @car_selected = Car.where("id = ? AND owner_id = ?", params[:car_id], current_user.owner.id).last
        cookies[:selected_car_id] = params[:car_id]
      end
      unless @car_selected.present?
        Rails.logger.info "Auto no encotrado con cookie"
        not_found
      end
    end
  end

  def general_redirections
    # Complete owner information it there is not yet registered
    if user_signed_in? && (params[:controller].downcase != 'owners' && params[:action].downcase != "new")
      if current_user.owner.nil?
        Rails.logger.info "ApplicationController#general_redirections::new_owner_path"
        redirect_to new_owner_path
      end
    end
    # Update current km at least 24 hours difference
    if current_user.present? && current_user.owner.present? && (request.method.downcase == 'get')
      if current_user.owner.cars.count > 0
        delayed_cars = current_user.owner.cars.to_a.select {|c| ((Time.now - c.updated_at)/1.hour).round >= 24}.length
        if delayed_cars > 0
          Rails.logger.info "ApplicationController#general_redirections::update_current_kms_cars_path"
          redirect_to update_current_kms_cars_path
        end
      end
    end
  end

  def set_referer
    # Rails.logger.info "============================= REQUEST.REFERER"
    # Rails.logger.info request.referer.inspect
    cookies[:request_referer] = request.referer
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def clean_car_selection_cookie
    cookies.delete :selected_car_id
  end

  def set_car_selection_cookie
    cookies[:selected_car_id] = @car.id
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
  
  protected
    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || cars_path
    end
    
  private
    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      clean_car_selection_cookie
      root_path
    end
end
