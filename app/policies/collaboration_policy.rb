class CollaborationPolicy < ApplicationPolicy

  def initialize(user, collaboration)
    @user = user
    @collaboration = collaboration
    @wiki = Wiki.find(collaboration.wiki_id)
  end

  def create?
    authorized_for_this_private_wiki? 
  end 

  def destroy?
    authorized_for_this_private_wiki?
  end

  def authorized_for_this_private_wiki?
    @user && (@wiki.owner?(@user) || @user.admin? || @wiki.collaborators.include?(@user))
  end

end
