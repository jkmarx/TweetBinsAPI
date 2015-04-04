class UserAuthentication < ActiveRecord::Base
  belongs_to :user

  serialize :params

  def self.create_from_omniauth(params, user, provider)
    create(
      user: user,
      token: params['oauth_token'],
      token_expires_at: 1.day.from_now.to_datetime,
      params: params,
    )
  end
end
