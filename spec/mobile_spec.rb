require 'spec_helper'
require_relative '../lib/mobile.rb'

describe 'Mobile' do
  describe '#balanced?' do
    it 'returns true when balanced' do
      mobile = Mobile.new

      level_one = mobile.add_rod(4)
      level_one.add_weight(10, 0)
      level_two = level_one.add_rod(2, 4)
      level_two.add_weight(5, 0)
      level_two.add_weight(5, 2)

      expect(mobile.balanced?).to be true
    end

    it 'returns false when not balanced' do
      mobile = Mobile.new

      level_one = mobile.add_rod(4)
      level_one.add_weight(5, 0)
      level_one.add_weight(10, 4)

      expect(mobile.balanced?).to be false
    end
  end

  describe '#add_rod' do
    it 'adds a rod to the mobile' do
      mobile = Mobile.new

      mobile.add_rod(5)

      expect(mobile.rod).to_not be_nil
    end
  end
end
