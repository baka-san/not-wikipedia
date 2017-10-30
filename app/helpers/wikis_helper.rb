module WikisHelper
  def authorized_for_private_wikis?
    current_user.admin? || current_user.premium?
  end
end
