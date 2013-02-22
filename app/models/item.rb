class Item < ActiveRecord::Base
  attr_accessible :image, :name, :price

  has_many :selections
  has_many :carts, through: :selections

  def as_json(options = {})
    {
      id: id,
      name: name,
      price: price
    }
  end
end
