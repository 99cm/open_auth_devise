class Spree::Admin::UserSessionsController < Devise::SessionsController
  helper 'spree/base'

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Store

  helper 'spree/admin/navigation'
  layout :resolve_layout

  def create
    authenticate_spree_user!

    if spree_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = I18n.t('spree.logged_in_succesfully')
          redirect_back_or_default(after_sign_in_path_for(spree_current_user))
        }
        format.js {
          user = resource.record
          render json: { ship_address: user.ship_address, bill_address: user.bill_address }.to_json
        }
      end
    else
      flash.now[:error] = I18n.t('devise.failure.invalid')
      render :new
    end
  end

  def authorization_failure
    return if try_spree_current_user
    store_location
    return redirect_to spree.admin_login_path
  end

  protected

  def translation_scope
    'devise.user_sessions'
  end

  private

  def accurate_title
    I18n.t('spree.login')
  end

  def redirect_back_or_default(default)
    redirect_to(session["spree_user_return_to"] || default)
    session["spree_user_return_to"] = nil
  end

  def resolve_layout
    case action_name
    when "new", "create"
      "spree/layouts/login"
    else
      "spree/layouts/admin"
    end
  end
end