class Wiki < ApplicationRecord
  # belongs_to :user
  # has_many :collaborations, dependent: :destroy 
  # has_many :users, through: :collaborations

  belongs_to :user
  has_many :collaborations, class_name: "Collaboration",
                            foreign_key: "wiki_id",
                            dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :collaborator

  validates :title, length: {minimum: 1}, presence: true
  validates :body, length: {minimum: 1}, presence: true
  validates :user, presence: true


  def private?
    self.private
  end

end
