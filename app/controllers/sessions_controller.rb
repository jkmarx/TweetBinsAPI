class SessionsController < ApplicationController
  def create
    byebug;
    user = User.where(:twitterUsername => auth["twitterUsername"])
    byebug;
    url = session[:return_to] || root_path
    session[:return_to] = nil
    url = root_path if url.eql?('/logout')

    if user.save
      session[:user_id] = user.id
      render status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
