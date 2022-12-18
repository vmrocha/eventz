class Event < ApplicationRecord

  class << self
    def upcomming
      where("starts_at > ?", Time.now).order("starts_at")
    end
  end

  def free?
    price.blank? || price == 0
  end
end
