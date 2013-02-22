class Cart < ActiveRecord::Base
  attr_accessible :session_token

  has_one :user
  has_many :selections
  has_many :items, through: :selections

  def as_json(options = {})
    items_copy = items
    total_price = items_copy.inject(0) { |total, item| item.price + total }

    unique_items = []

    items_copy.each do |item|
      exists = unique_items.index { |u| u[:id] == item.id }

      if exists
        unique_items[exists][:count] += 1
      else
        unique_items.push({name: item.name, count: 1, id: item.id})
      end
    end

    unique_items.sort! {|i1, i2| i1[:name]<=>i2[:name] }

    {
      user: user,
      unique_items: unique_items,
      total_price: total_price
    }
  end

end
