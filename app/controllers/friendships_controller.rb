class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend: friend)
    if current_user.save
      flash[:notice] = "Following user"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to my_friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Friend was successfully removed"
    redirect_to my_friends_path
  end
end
