# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :subs,
    class_name: :Sub,
    primary_key: :id,
    foreign_key: :user_id

  has_many :posts
  has_many :comments
  has_many :votes

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(64)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
