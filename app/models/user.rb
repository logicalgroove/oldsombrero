class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :provider, type: String
  field :uid, type: String

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :name

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  field :name, :type => String
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at

  #relations
  has_many :items
  has_and_belongs_to_many :following, class_name: 'User', inverse_of: :followers
  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following
  has_and_belongs_to_many :tags

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).find_or_create_by do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], :without_protection => true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def owns?(id)
    items.where(:_id => id).first ? true : false
  end

  def follow_user(user)
    if self.id != user.id and !self.following.include?(user)
      self.following << user
    end
  end

  def unfollow_user(user)
    self.following.delete(user)
  end

  def follows_user?(user)
    self.following.include?(user)
  end

  def follow_tag(tag)
    self.tags << tag
  end

  def unfollow_tag(tag)
    self.tags.delete(tag)
  end

  def follows_tag?(tag)
    self.tags.include?(tag)
  end

end
