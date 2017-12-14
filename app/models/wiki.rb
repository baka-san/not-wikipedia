class Wiki < ApplicationRecord
  # belongs_to :user
  # has_many :collaborations, dependent: :destroy 
  # has_many :users, through: :collaborations

  belongs_to :user
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user

  validates :title, length: {minimum: 1}, presence: true
  validates :body, length: {minimum: 1}, presence: true
  validates :user, presence: true


  def private?
    self.private
  end

  def public?
    !self.private
  end

  def owner
    self.user
  end

  def collaborators?
    !self.collaborators.empty?
  end

end
