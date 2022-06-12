# frozen_string_literal: true

require_relative '../lib/checker'

describe Checker do
  describe '#to_str' do
    context 'when the checker is red' do
      subject(:red_checker) { described_class.new(:red, 3, 1) }
      it 'prints a red circle with space around it' do
        expect(red_checker.to_str).to eq(' 🔴 ')
      end
    end

    context 'when the checker is yellow' do
      subject(:yellow_checker) { described_class.new(:yellow, 3, 1) }
      it 'prints a red circle with space around it' do
        expect(yellow_checker.to_str).to eq(' 🟡 ')
      end
    end
  end
end
