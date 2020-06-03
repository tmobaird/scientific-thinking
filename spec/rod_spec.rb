require 'spec_helper'
require_relative '../lib/rod'

describe 'Rod' do
  describe '#perfectly_balanced?' do
    context 'single level' do
      it 'returns true when balanced' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        rod.add_weight(10, 5)

        expect(rod.perfectly_balanced?).to be true
      end

      it 'returns false when not balanced' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        rod.add_weight(11, 5)

        expect(rod.perfectly_balanced?).to be false
      end
    end

    context 'two levels' do
      it 'returns true when both levels are balanced' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        level_two = rod.add_rod(2, 5)
        level_two.add_weight(5, 0)
        level_two.add_weight(5, 2)

        expect(rod.perfectly_balanced?).to be true
      end

      it 'returns false when bottom level is not balanced' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        level_two = rod.add_rod(2, 5)
        level_two.add_weight(4, 0)
        level_two.add_weight(6, 2)

        expect(rod.perfectly_balanced?).to be false
      end
    end

    context 'three levels' do
      it 'returns true when all levels are balanced' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        level_two = rod.add_rod(2, 5)
        level_two.add_weight(5, 0)
        level_three = level_two.add_rod(2, 2)
        level_three.add_weight(2.5, 0)
        level_three.add_weight(2.5, 2)

        expect(rod.perfectly_balanced?).to be true
      end

      it 'returns false when second level is not balanced' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        level_two = rod.add_rod(2, 5)
        level_two.add_weight(4, 0)
        level_three = level_two.add_rod(2, 2)
        level_three.add_weight(2.5, 0)
        level_three.add_weight(2.5, 2)

        expect(rod.perfectly_balanced?).to be false
      end

      it 'returns false when third level is not balanced' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        level_two = rod.add_rod(2, 5)
        level_two.add_weight(5, 0)
        level_three = level_two.add_rod(2, 2)
        level_three.add_weight(2.5, 0)
        level_three.add_weight(3, 2)

        expect(rod.perfectly_balanced?).to be false
      end
    end
  end

  describe '#balanced?' do
    context 'general rules' do
      context 'when weights are imbalanced with equal distance' do
        it 'returns false' do
          rod = Rod.new(5)

          rod.add_weight(10, 0)
          rod.add_weight(9, 5)

          expect(rod.balanced?).to be false
        end
      end

      context 'when weights are equal and equal distance from center' do
        it 'returns true' do
          rod = Rod.new(5)

          rod.add_weight(10, 0)
          rod.add_weight(10, 5)

          expect(rod.balanced?).to be true
        end
      end

      context 'when weights are the equal but distances are different' do
        it 'returns false' do
          rod = Rod.new(5)

          rod.add_weight(10, 1)
          rod.add_weight(10, 5)

          expect(rod.balanced?).to be false
        end
      end
    end
  end

  describe '#total_weight' do
    it 'is the combined total of all weights' do
      rod = Rod.new(5)
      rod.add_weight(1, 1)
      rod.add_weight(2, 2)
      rod.add_weight(3, 3)
      rod.add_weight(4, 4)

      expect(rod.total_weight).to eq(10)
    end

    context 'multiple levels' do
      it 'includes combined total of weights at all levels' do
        rod = Rod.new(5)

        rod.add_weight(1, 0)
        child = rod.add_rod(1, 2)
        child.add_weight(1, 0)

        expect(rod.total_weight).to eq(2)
        expect(child.total_weight).to eq(1)
      end

      it 'works for 3 levels' do
        rod = Rod.new(5)

        rod.add_weight(10, 0)
        second_rod = rod.add_rod(1, 2)
        second_rod.add_weight(10, 0)
        third_rod = second_rod.add_rod(2, 0)
        third_rod.add_weight(10, 0)

        expect(rod.total_weight).to eq(30)
      end
    end
  end

  describe '#total_force' do
    it 'returns 0 when force is equal' do
      rod = Rod.new(5)
      rod.add_weight(10, 0)
      rod.add_weight(10, 5)

      expect(rod.total_force).to eq(0)
    end

    it 'returns negative number when more force on left' do
      rod = Rod.new(5)
      rod.add_weight(10, 0)
      rod.add_weight(10, 4)

      expect(rod.total_force).to eq(-10)
    end

    it 'returns positive number when more force on right' do
      rod = Rod.new(5)
      rod.add_weight(10, 1)
      rod.add_weight(10, 5)

      expect(rod.total_force).to eq(10)
    end

    context 'multiple levels' do
      it 'includes combined total of weights at all levels' do
        rod = Rod.new(5)

        rod.add_weight(1, 0)
        child = rod.add_rod(1, 2)
        child.add_weight(1, 0)

        expect(rod.total_force).to eq(-3)
      end

      it 'works for 3 levels' do
        rod = Rod.new(5)

        rod.add_weight(10, 0) # -25
        second_rod = rod.add_rod(1, 2) # -10
        second_rod.add_weight(10, 0)
        third_rod = second_rod.add_rod(2, 0)
        third_rod.add_weight(10, 0)

        expect(rod.total_force).to eq(-35)
      end
    end
  end

  describe '#add_weight' do
    it 'adds a weight at a specific location' do
      rod = Rod.new(5)

      rod.add_weight(10, 1)

      expect(rod.weights.count).to eq(1)
      weight = rod.weights.first
      expect(weight.weight).to eq(10)
      expect(weight.place).to eq(1)
    end
  end

  describe '#add_rod' do
    it 'adds a rod at a specific location' do
      rod = Rod.new(5)

      rod.add_rod(2, 0)

      expect(rod.rods.count).to eq(1)
      child_rod = rod.rods.first
      expect(child_rod.length).to eq(2)
      expect(child_rod.place).to eq(0)
    end
  end
end