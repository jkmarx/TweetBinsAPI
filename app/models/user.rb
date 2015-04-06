class User < ActiveRecord::Base
  has_many :categories


  validates_uniqueness_of :twitterUsername, :twitterUserId

  before_create :generate_token

  def generate_token
    return if token.present?
    begin
      self.token = SecureRandom.uuid.gsub(/\-/,'')
    end while self.class.exists?(token: token)
  end
end

