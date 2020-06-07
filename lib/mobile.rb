require_relative 'rod'

class Mobile
  attr_reader :rod

  def balanced?
    rod.perfectly_balanced?
  end

  def add_rod(length)
    @rod = Rod.new(length)
  end
end
