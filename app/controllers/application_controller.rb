class ApplicationController < ActionController::Base
  before_action :set_car_with_cookies
  before_action :complete_owner
  def complete_owner
    if user_signed_in? && (params[:controller].downcase != 'owners' && params[:action].downcase != "new")
      if current_user.owner.nil?
        redirect_to new_owner_path
      end
    end
  end

  def set_car_with_cookies
    if cookies[:selected_car_id].present?
      @car_selected = Car.where("id = ? AND owner_id = ?", cookies[:selected_car_id], current_user.owner.id).last
      unless @car_selected.present?
        Rails.logger.info "Auto no encotrado con cookie"
        not_found
      end
    end
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

  protected
    def after_sign_in_path_for(resource)
      cars_path
    end
end
