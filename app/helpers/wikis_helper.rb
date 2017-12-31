module WikisHelper

  def authorized_for_this_private_wiki?
    current_user && (current_user == @wiki.user || current_user.admin?)
  end

end
