class WikiPolicy < ApplicationPolicy

  # Public    index | show | new | create | edit | update | destroy | Private (all)
  # Guest        x      x
  # Standard     x      x     x       x      x      x        x
  # Premium      x      x     x       x      x      x        x           x   (own)
  # Admin = everything

  def initialize(user, wiki)
    # raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @wiki = wiki
  end

  def show?
    if @wiki.private?
      # raise Pundit::NotAuthorizedError, "must be logged in" unless @user
      authorized_for_this_private_wiki?
    else
      true
    end
  end

  def create?
    if @wiki.private?
      authorized_for_this_private_wiki?
    else
      @user.present?
    end
  end 

  def update?
    if @wiki.private?
      authorized_for_this_private_wiki?
    else
      @user.present?
    end
  end

  def destroy?
    if @wiki.private?
      authorized_for_this_private_wiki?
    else
      @user.present?
    end
  end

  def authorized_for_this_private_wiki?
    @user && (@user.premium? || @user.admin?)
  end

  class Scope < Scope
    def resolve
      if @user && (@user.premium? || @user.admin?)
        scope.all
      else 
        scope.where(private: false)
      end
    end
  end

end
