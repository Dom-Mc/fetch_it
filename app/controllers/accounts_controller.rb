class AccountsController < ApplicationController
  include AccountsHelper

  before_action :authenticate_user!
  skip_before_action :complete_account_signup, only: [:new, :create]
  before_action :verify_user_is_new, only: [:new, :create]
  before_action :set_user_account, only: [:show, :edit, :update]
  after_action :verify_authorized, except: :index

  def new
    @user_account = current_user.build_account
    authorize @user_account
  end

  def create
    @user_account = current_user.build_account(account_params)
    authorize @user_account
    if @user_account.save
      redirect_to @user_account, notice: "Your account is now active!"
    else
      render :new
    end
  end

  def show
    authorize @user_account
  end

  def edit
    authorize @user_account
  end

  def update
    authorize @user_account
    if @user_account.update(account_params)
      redirect_to @user_account, notice: "Your account was successfully updated!"
    else
      render :edit
    end
  end

  private

    def verify_user_is_new
      if current_user && current_user.account.present?
        redirect_to current_user.account
      end
    end

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

end
