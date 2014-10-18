class User < ActiveRecord::Base
  def self.create_from_omniauth(params)
    email = params['info']['email'] || "#{params['uid']}@nikyak.com"
    attributes = {
      email: email,
      password: Devise.friendly_token
    }

    create(attributes)
  end

  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :niks

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
