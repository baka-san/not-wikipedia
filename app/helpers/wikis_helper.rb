module WikisHelper

  def authorized_for_this_private_wiki?
    current_user && (@wiki.owner?(current_user) || current_user.admin? || current_user.collaborating_on?(@wiki))
  end

end
