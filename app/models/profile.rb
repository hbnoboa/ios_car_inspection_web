class Profile
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  ## Database authenticatable
  field :email,                type: String, default: ""
  field :name,                 type: String, default: ""
  field :login,                type: String, default: ""
  field :role,                 type: String, default: ""
  field :encrypted_password,   type: String, default: ""
  field :authentication_token, type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
   field :sign_in_count,      type: Integer, default: 0
   field :current_sign_in_at, type: Time
   field :last_sign_in_at,    type: Time
   field :current_sign_in_ip, type: String
   field :last_sign_in_ip,    type: String

  ## Confirmable
   #field :confirmation_token,   type: String
   #field :confirmed_at,         type: Time
   #field :confirmation_sent_at, type: Time
   #field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  include Mongoid::Timestamps

  ROLES = ["User", "Manager", "Admin"].freeze

  def ensure_authentication_token
    self.authentication_token ||= generate_unique_token
  end
  
  def generate_unique_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)
    end
  end
end
