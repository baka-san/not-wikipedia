class CollaborationPolicy < ApplicationPolicy
  # Guest: nothing
  # Standard: delete(own), create(any)
  # Premium: delete(own), delete(any on own private wikis), create(any)
  # Admin = everything


  def initialize(user, collaboration)
    @user = user
    @collaboration = collaboration
    @wiki = Wiki.find(collaboration.wiki_id)
  end


  def create?
    @user.collaborating_on?(@wiki)
  end 


  def destroy?
    @user.collaborating_on?(@wiki)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
