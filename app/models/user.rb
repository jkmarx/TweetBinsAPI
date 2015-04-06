class User < ActiveRecord::Base
  has_many :categories


  validates_uniqueness_of :twitterUsername, :twitterUserId

  before_create :generate_token

  def generate_token
    return if appToken.present?
    begin
      self.appToken = SecureRandom.uuid.gsub(/\-/,'')
    end while self.class.exists?(appToken: appToken)
  end
end

