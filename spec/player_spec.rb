# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:player1) { described_class.new(:red, 1) }
  describe '#make_move' do
    context 'when the user inputs a valid move' do
      before do
        allow(player1).to receive(:player_move_prompt).and_return('0')
      end

      it 'sends a message to prompt the user to input a move once' do
        expect(player1).to receive(:player_move_prompt).exactly(1).time
        player1.make_move
      end

      it 'returns the valid move as an integer' do
        expect(player1.make_move).to eq(0)
      end
    end

    context 'when the user inputs an invalid move followed by a valid move' do
      before do
        allow(player1).to receive(:player_move_prompt).and_return('foo', '6')
      end

      it 'sends a message to prompt the user to input a move twice' do
        expect(player1).to receive(:player_move_prompt).exactly(2).times
        player1.make_move
      end

      it 'returns the valid move as an integer' do
        expect(player1.make_move).to eq(6)
      end
    end

    context 'when the user inputs two invalid moves followed by a valid move' do
      before do
        allow(player1).to receive(:player_move_prompt).and_return('foo', '!', '3')
      end

      it 'sends a message to prompt the user to input a move three times' do
        expect(player1).to receive(:player_move_prompt).exactly(3).times
        player1.make_move
      end

      it 'returns the valid move as an integer' do
        expect(player1.make_move).to eq(3)
      end
    end
  end
end
