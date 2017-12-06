class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy

  has_one :subscription, dependent: :destroy

  before_save { self.role ||= :standard }
  after_create :skip_user_confirmation!

  enum role: [:standard, :premium, :admin]

  # def authorized_for_this_private_wiki?(wiki)
  #   self && (self == wiki.user || self.admin?)
  # end

  def upgraded_account?
    self.premium? || self.admin?
  end

  def downgrade_to_standard
    self.role = "standard"
  end

  def upgrade_to_premium
    self.role = "premium"
  end

  def upgrade_to_admin
    self.role = "admin"
  end

  private 
    def skip_user_confirmation!
      self.confirm if Rails.env.development? || Rails.env.test?
    end

end
