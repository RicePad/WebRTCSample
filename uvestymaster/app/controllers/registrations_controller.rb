class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :first_name, :last_name, :email, :about, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :first_name, :last_name, :email, :about, :password, :password_confirmation, :current_password, :account, :routing, :country, :card, :cvv, :expmonth, :expyear)
  end
end