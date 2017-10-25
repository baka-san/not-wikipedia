class WikiPolicy < ApplicationPolicy

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  class Scope < Scope
    def resolve
      scope.where(private: false)
    end
  end
end
