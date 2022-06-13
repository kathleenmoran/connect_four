# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#play_round' do
    subject(:game) { described_class.new }
    let(:checker) { instance_double(Checker, color: :red, x: 5, y: 1) }
    context 'when a valid move is entered' do
      before do
        allow(game.instance_variable_get(:@active_player)).to receive(:make_move).and_return(1)
        allow(game.instance_variable_get(:@board)).to receive(:valid_move?).and_return(true)
        allow(game.instance_variable_get(:@board)).to receive(:place_checker).and_return(checker)
        allow($stdout).to receive(:write)
      end

      it 'sends a message to prompt the active user for a move once' do
        expect(game.instance_variable_get(:@active_player)).to receive(:make_move).exactly(1).time
        game.play_round
      end

      it 'sends a message to update the board once' do
        expect(game.instance_variable_get(:@board)).to receive(:place_checker).exactly(1).time
        game.play_round
      end

      it 'updates the last checker' do
        expect { game.play_round }.to change { game.instance_variable_get(:@last_checker) }
      end
    end

    context 'when an invalid move is entered follow by a valid move' do
      before do
        allow(game.instance_variable_get(:@active_player)).to receive(:make_move).and_return(-1, 1)
        allow(game.instance_variable_get(:@board)).to receive(:valid_move?).and_return(false, true)
        allow(game.instance_variable_get(:@board)).to receive(:place_checker).and_return(checker)
        allow($stdout).to receive(:write)
      end

      it 'sends a message to prompt the active user for a move twice' do
        expect(game.instance_variable_get(:@active_player)).to receive(:make_move).exactly(2).times
        game.play_round
      end

      it 'sends a message to update the board once' do
        expect(game.instance_variable_get(:@board)).to receive(:place_checker).exactly(1).time
        game.play_round
      end

      it 'updates the last checker' do
        expect { game.play_round }.to change { game.instance_variable_get(:@last_checker) }
      end

      it 'sends a message to print the invalid move message once' do
        expect(game).to receive(:invalid_move_message).exactly(1).time
        game.play_round
      end
    end

    context 'when two invalid moves are entered followed by a valid move' do
      before do
        allow(game.instance_variable_get(:@active_player)).to receive(:make_move).and_return(-1, 7, 1)
        allow(game.instance_variable_get(:@board)).to receive(:valid_move?).and_return(false, false, true)
        allow(game.instance_variable_get(:@board)).to receive(:place_checker).and_return(checker)
        allow($stdout).to receive(:write)
      end

      it 'sends a message to prompt the active user for a move three times' do
        expect(game.instance_variable_get(:@active_player)).to receive(:make_move).exactly(3).times
        game.play_round
      end

      it 'sends a message to update the board once' do
        expect(game.instance_variable_get(:@board)).to receive(:place_checker).exactly(1).time
        game.play_round
      end

      it 'updates the last checker' do
        expect { game.play_round }.to change { game.instance_variable_get(:@last_checker) }
      end

      it 'sends a message to print the invalid move message twice' do
        expect(game).to receive(:invalid_move_message).exactly(2).times
        game.play_round
      end
    end
  end

  describe '#play_game' do
    subject(:game) { described_class.new }
    context 'when the game is a tie' do
      before do
        allow(game.instance_variable_get(:@board)).to receive(:win?).and_return(false)
        allow(game).to receive(:play_round)
        allow($stdout).to receive(:write)
      end

      it 'prints the board 42 times' do
        expect(game.instance_variable_get(:@board)).to receive(:to_s).exactly(43).times
        game.play_game
      end

      it 'sends a message to play a round 42 times' do
        expect(game).to receive(:play_round).exactly(42).times
        game.play_game
      end

      it 'sends a message to switch the active player 42 times' do
        expect(game).to receive(:switch_active_player).exactly(42).times
        game.play_game
      end

      it 'sends a message to end the game once' do
        expect(game).to receive(:end_game).exactly(1).time
        game.play_game
      end
    end

    context 'when the game is won after 8 rounds' do
      before do
        allow(game.instance_variable_get(:@board)).to receive(:win?).and_return(false, false, false, false, false, false, false, true)
        allow(game).to receive(:play_round)
        allow($stdout).to receive(:write)
      end

      it 'prints the board 8 times' do
        expect(game.instance_variable_get(:@board)).to receive(:to_s).exactly(9).times
        game.play_game
      end

      it 'sends a message to play a round 8 times' do
        expect(game).to receive(:play_round).exactly(8).times
        game.play_game
      end

      it 'sends a message to switch the active player 7 times' do
        expect(game).to receive(:switch_active_player).exactly(7).times
        game.play_game
      end

      it 'sends a message to end the game once' do
        expect(game).to receive(:end_game).exactly(1).time
        game.play_game
      end
    end
  end

  describe '#end_game' do
    subject(:game) { described_class.new }
    
    context 'when the game is won' do
      before do
        allow(game.instance_variable_get(:@board)).to receive(:win?).and_return(true)
        allow($stdout).to receive(:write)
      end

      it 'prints the board' do
        expect(game.instance_variable_get(:@board)).to receive(:to_s)
        game.end_game
      end

      it 'sends a message for the active player to print the win message' do
        expect(game.instance_variable_get(:@active_player)).to receive(:win_game)
        game.end_game
      end
    end

    context 'when the game is a tie' do
      before do
        allow(game.instance_variable_get(:@board)).to receive(:win?).and_return(false)
        allow($stdout).to receive(:write)
      end

      it 'prints the board' do
        expect(game.instance_variable_get(:@board)).to receive(:to_s)
        game.end_game
      end

      it 'sends a message for to print the tie message' do
        expect(game).to receive(:tie_game_message)
        game.end_game
      end
    end
  end
end
