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

  def show?
    if @wiki.private?
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
    @user && (@wiki.owner?(@user) || @user.admin? || @wiki.collaborators.include?(@user))
  end

  class Scope < Scope

    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end


    def resolve
      wikis = []

      if user && user.admin?
        wikis = scope.all

      elsif user && user.premium?
        all_wikis = scope.all

        all_wikis.each do |wiki|
          if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end

      else
        all_wikis = scope.all

        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end

      wikis 
    end
  end

end
