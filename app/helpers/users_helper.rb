module UsersHelper 
  def change_account_status(user)
    email = user.email
    active    = user.account_status == User::ACTIVE ? true : false 
    text = active ? "block #{email}" : "unblock #{email}"

    link_to text, account_status_admin_user_path(user), method: :post
  end
end