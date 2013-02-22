class PhotosController < ApplicationController
  def show
    item = Item.find(params[:id])
    send_data(item.image, :type => 'image/jpg', :disposition => 'inline')
  end
end
