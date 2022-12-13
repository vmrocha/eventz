class Event < ApplicationRecord
  def free?
    price.blank? || price == 0
  end
end
