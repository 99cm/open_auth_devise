class Spree::UserRegistrationsController < Devise::RegistrationsController
  helper 'spree/base'

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Store

  if defined?(SpreeI18n::ControllerLocaleHelper)
    include SpreeI18n::ControllerLocaleHelper
  end

  before_action :check_permissions, only: [:edit, :update]
  skip_before_action :require_no_authentication

  def create
    build_resource(spree_user_params)
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up
        sign_up(resource_name, resource)
        session[:spree_user_signup] = true
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with(resource) do |format|
        format.html { render :new }
      end
    end
  end

  protected

  def check_permissions
    authorize!(:create, resource)
  end

  def translation_scope
    'devise.user_registrations'
  end

  private

  def spree_user_params
    params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes) | [:email])
  end
end