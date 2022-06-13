# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# a game of connect four
class Game
  include Displayable
  def initialize
    @board = Board.new
    @player1 = Player.new(:red, 1)
    @player2 = Player.new(:yellow, 2)
    @active_player = @player1
    @last_checker = nil
  end

  def play_round
    move = @active_player.make_move
    if @board.valid_move?(move)
      @last_checker = @board.place_checker(move, @active_player.color)
    else
      invalid_move_message
      play_round
    end
  end

  def play_game
    (Constants::WIDTH * Constants::HEIGHT).times do
      puts @board
      play_round
      break if @board.win?(@last_checker)

      switch_active_player
    end
    end_game
  end

  def switch_active_player
    @active_player = @active_player == @player1 ? @player2 : @player1
  end

  def end_game
    puts @board
    if @board.win?(@last_checker)
      @active_player.win_game
    else
      tie_game_message
    end
  end
end
