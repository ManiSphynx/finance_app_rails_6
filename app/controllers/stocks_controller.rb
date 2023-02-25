class StocksController < ApplicationController
  before_action :present_params, only: %i[search]

  def search
    @stock = Stock.new_lookup(params[:stock])
    @user = current_user

    if @stock
      respond_to { |format| format.js { render partial: "users/result" } }
    end

    unless @stock
      respond_to do |format|
        flash.now[:alert] = "Not found, please another symbol"
        format.js { render partial: "users/result" }
      end
    end
  end

  private

  def present_params
    unless params[:stock].present?
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: "users/result" }
      end
    end
  end
end
