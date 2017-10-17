class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  after_create :skip_user_confirmation!





  private 
    def skip_user_confirmation!
      self.confirm if Rails.env.development?
    end

end
