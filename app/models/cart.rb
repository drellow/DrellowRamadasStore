class Cart < ActiveRecord::Base
  attr_accessible :session_token

  has_one :user
  has_many :selections
  has_many :items, through: :selections

  def as_json(options = {})
    {
      user: user,
      items: items
    }
  end

end
