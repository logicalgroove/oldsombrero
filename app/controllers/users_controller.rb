class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.where(:_id => params[:id]).first
  end

end
