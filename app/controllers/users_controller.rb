class UsersController < ApplicationController

  def update_role
    user = User.find(params[:id])
    if user.update(role_params)
      # TODO: Update notice
      redirect_to accounts_path, notice: "Saved"
    else
      # TODO: Update notice
      redirect_to accounts_path, notice: "Did not save"
    end
  end

  private

    def role_params
      params[:user].permit(:role)
    end

end
