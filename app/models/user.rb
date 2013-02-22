class User < ActiveRecord::Base
  attr_accessible :cart_id, :username

  belongs_to :cart
  has_many :items, through: :cart

end
