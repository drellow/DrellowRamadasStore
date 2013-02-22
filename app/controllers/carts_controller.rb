class CartsController < ApplicationController
  before_filter :set_cart

  def set_cart
    @cart = Cart.find(session[:cart_id]) if session[:cart_id]

    unless @cart
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def show
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @cart }
    end
  end

  def update
    puts "--------------"
    puts params
    puts "--------------"
    @cart.items << Item.find(params[:id])
    render nothing: true
  end
end
