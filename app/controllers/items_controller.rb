class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @item }
    end
  end

  def index
    @items = Item.all

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @items }
    end
  end
end
