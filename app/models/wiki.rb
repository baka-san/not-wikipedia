class Wiki < ApplicationRecord

  # scope :own_wikis_scope, -> { where(user_id: @user_id) }
  # scope :collaborating_scope, -> user { if user.collaborating.include?() }

  belongs_to :user
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user
  accepts_nested_attributes_for :collaborations

  validates :title, length: {minimum: 1}, presence: true
  validates :body, length: {minimum: 1}, presence: true
  validates :user, presence: true


  # class CurrentUserScope < Scope

  #   def resolve
  #     scope.where(user_id: @user_id)
  #   end
  # end

  # class CollaboratingScope < Scope

  #   def resolve
  #     wikis = []

  #     scope.each do |wiki|
  #       if user.collaborating.include?(wiki)
  #         wikis << wiki
  #       end
  #     end

  #     wikis
  #   end
  # end

  def private?
    self.private
  end

  def public?
    !self.private
  end

  def owner
    self.user
  end

  def owner?(user)
    self.user == user
  end

  def collaborators?
    !self.collaborators.empty?
  end

end
