# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    user = User.new(permitted_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice: 'User created!'
    else
      flash.alert = 'Unable to create user'
      redirect_to signup_path
    end
  end

  def show
    @user = current_user
  end

  def update
    if current_user.update(permitted_params.compact)
      flash.notice = 'Details updated!'
    else
      flash.alert = 'Unable to update details!'
    end
    redirect_to edit_user_path(current_user.id)
  end

private

  def permitted_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation
    )
  end
end
