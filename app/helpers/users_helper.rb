module UsersHelper
  def account_types
    User.account_types.keys.to_a
  end

  def display_account_type
    @user.profile.account_type
  end
end
