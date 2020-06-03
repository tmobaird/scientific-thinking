require 'spec_helper'
require_relative '../lib/mobile.rb'

describe 'Mobile' do
  describe '#balanced?' do
    it 'returns true' do
      mobile = Mobile.new

      expect(mobile.balanced?).to be true
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