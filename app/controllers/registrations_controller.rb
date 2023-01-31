class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = "An email was sent to confirm your account"
    new_user_session_path
  end
end