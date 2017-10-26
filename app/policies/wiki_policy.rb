class WikiPolicy < ApplicationPolicy

  # Public    index | show | new | create | edit | update | destroy | Private (all)
  # Guest        x      x
  # Standard     x      x     x       x      x      x        x
  # Premium      x      x     x       x      x      x        x           x   (own)
  # Admin = everything

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def create?
    if wiki.private?
      user.premium? || user.admin?
    end
  end 

  def new?
    create?
  end

  def update?
    wiki.user == current_user || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    wiki.user == current_user || user.admin?
  end

  class Scope < Scope
    def resolve
      if user && (user.admin? || user.premium?)
        scope.all
      else 
        scope.where(private: false)
      end
    end
  end

end
