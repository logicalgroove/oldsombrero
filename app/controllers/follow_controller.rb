class FollowController < ApplicationController
  def follow_user
    @user = User.find(params[:id])
    current_user.follow_user(@user)
    redirect_to @user, :notice => "You are now following user #{@user.name}"
  end

  def follow_tag
    @tag = Tag.find(params[:id])
    current_user.follow_tag(@tag)
    redirect_to @tag, :notice => "You are now following tag #{@tag.name}"
  end

end
