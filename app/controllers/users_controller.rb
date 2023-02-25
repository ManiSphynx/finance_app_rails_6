class UsersController < ApplicationController
  before_action :require_friend, only: %i[search]

  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    @friend = User.search(params[:friend])
    @friend = current_user.except_current_user(@friend)

    if @friend
      respond_to do |format|
        format.js { render partial: "users/friend_result" }
      end
    end

    unless @friend
      respond_to do |format|
        flash.now[:alert] = "Couldn't find user"
        format.js { render partial: "users/friend_result" }
      end
    end
  end

  private

  def require_friend
    unless params[:friend].present?
      respond_to do |format|
        flash.now[:alert] = "Please enter a name or email to search"
        format.js { render partial: "users/friend_result" }
      end
    end
  end
end
