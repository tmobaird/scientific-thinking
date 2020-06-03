require_relative 'weight'

class Rod
  attr_reader :weights, :rods, :length, :place

  def initialize(length, place=nil)
    @length = length
    @weights = []
    @rods = []
    @place = place
  end

  def perfectly_balanced?
    balanced? && @rods.map(&:balanced?).all?(true)
  end

  def balanced?
    (total_force.to_f / total_weight.to_f) == 0
  end

  def add_weight(weight, place)
    new_weight = Weight.new(weight, place)
    @weights << new_weight
    new_weight
  end

  def add_rod(length, place)
    new_rod = Rod.new(length, place)
    @rods << new_rod
    new_rod
  end

  def total_weight
    total = @weights.reduce(0) { |sum, w| sum + w.weight }
    @rods.each do |r|
      total += r.total_weight
    end
    total
  end

  def total_force
    middle = @length.to_f / 2
    force = force_for(@weights, middle, :weight)
    child_force = force_for(@rods, middle, :total_weight)

    force + child_force
  end

  def force_for(items, middle, multiplier)
    forces = items.map do |i|
      if i.place > middle
        ((i.place - middle) * i.send(multiplier))
      elsif i.place < middle
        ((middle - i.place) * i.send(multiplier)) * -1
      else
        0
      end
    end

    forces.reduce(0, :+)
  end
end
