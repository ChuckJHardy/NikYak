class User < ActiveRecord::Base
  def self.create_from_omniauth(params)
    email = params['info']['email'] || "#{params['uid']}@nikyak.com"
    name  = if params['info']['first_name']
      "#{params['info']['first_name']} #{params['info']['last_name']}"
    else
      params['info']['name']
    end

    attributes = {
      email: email,
      name: name,
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

  validates :name, presence: true

  def contributions
    niks.
      without_root.
      joins("LEFT JOIN niks as roots ON niks.path @> roots.path AND roots.parent_id IS NULL").
      where("roots.id IS NULL")
  end
end
