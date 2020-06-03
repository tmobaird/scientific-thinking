require_relative 'rod'

class Mobile
  attr_reader :rod

  def balanced?
    true
  end

  def add_rod(length)
    @rod = Rod.new(length)
  end
end