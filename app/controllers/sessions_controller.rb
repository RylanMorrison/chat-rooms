# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: permitted_params[:email])
    if user.present? && user.authenticate(permitted_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      flash.alert = 'Invalid email or password'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end

  private

  def permitted_params
    params.permit(:email, :password)
  end
end
