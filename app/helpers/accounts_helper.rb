module AccountsHelper
  # def account
  #   @account ||= Account.friendly.find(params[:id])
  # end

  def display_phone_fields
    if @user_account.phones.present?
      @user_account.phones
    else
      @user_account.phones.build
    end
  end

  def display_address_fields
    if @user_account.addresses.present?
      @user_account.addresses
    else
      @user_account.addresses.build
    end
  end

end
