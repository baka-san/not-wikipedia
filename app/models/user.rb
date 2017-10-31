class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis, dependent: :destroy

  before_save { self.role ||= :standard }
  after_create :skip_user_confirmation!

  enum role: [:standard, :premium, :admin]

  # def authorized_for_this_private_wiki?(wiki)
  #   self && (self == wiki.user || self.admin?)
  # end

  private 
    def skip_user_confirmation!
      self.confirm if Rails.env.development?
    end

end
