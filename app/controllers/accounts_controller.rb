class AccountsController < ApplicationController
  include AccountsHelper
  before_action :authenticate_user!#, except: [:new, :create]
  before_action :verify_user_is_new!, only: [:new, :create]
  before_action :set_user_account, only: [:show, :edit, :update]
  # TODO: create a redirect for all users who don't have a account (put in applications controller) on create action.

  def new
    @user_account = current_user.build_account
  end

  def create
    binding.pry
    @user_account = current_user.build_account(account_params)
    if @user_account.save
      redirect_to @user_account
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user_account.update(account_params)
      redirect_to @user_account, notice: "Your account is now active!"
    else
      render :edit
    end
  end

  private

    def set_user_account
      @user_account = Account.friendly.find(params[:id])
    end

    def account_params
      params.require(:account).permit(
          :first_name,
          :last_name,
          :account_type,
          :company,
          addresses_attributes: [
            :address_type,
            :street_address,
            :secondary_address,
            :city,
            :state,
             :country,
            :zip

          ],
          phones_attributes: [
            :phone_type,
            :phone_number,
            :ext
          ]
      )
    end

    def verify_user_is_new!
      if current_user && current_user.account&.slug.present?
        redirect_to root_path
      end
      return false
    end


end
