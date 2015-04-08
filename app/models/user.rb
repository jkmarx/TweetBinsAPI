class User < ActiveRecord::Base
  has_many :categories, dependent: :destroy


  has_secure_password

  validates_uniqueness_of :twitterUsername, :email

  before_create :generate_token

  def generate_token
    return if token.present?
    begin
      self.token = SecureRandom.uuid.gsub(/\-/,'')
    end while self.class.exists?(token: token)
  end
end

