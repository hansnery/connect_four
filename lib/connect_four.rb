# frozen_string_literal: true

# :nodoc:
class ConnectFour
  require_relative 'board'

  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new('white', 'Player One')
    @player2 = Player.new('black', 'Player Two')
    define_colors
  end

  def define_colors
    @white = '⚪'
    @black = '⚫'
  end

  def check_for_win
    return if check_elements(@board.columns)
    return if check_elements(@board.lines)
    return if check_elements(@board.diagonals_left_to_right)
    return if check_elements(@board.diagonals_right_to_left)
  end

  def check_elements(array)
    white_counter = 0
    black_counter = 0
    array.each do |el|
      break if white_counter > 3 || black_counter > 3

      white_counter = count_balls(el, white_counter, @white)
      black_counter = count_balls(el, black_counter, @black)
    end
    show_winner(white_counter, black_counter)
  end

  def count_balls(array, counter, symbol)
    array.each do |el|
      break if counter > 3

      if el == symbol
        counter += 1
      else
        counter = 0
      end
    end
    counter
  end

  def show_winner(player1_counter, player2_counter)
    white = 'white'
    black = 'black'
    puts 'White wins!' if player1_counter > 3
    return white if player1_counter > 3

    puts 'Black wins!' if player2_counter > 3
    return black if player2_counter > 3
  end
end

game = ConnectFour.new
game.board.insert_ball(game.board.column1, game.player1)
game.board.insert_ball(game.board.column2, game.player2)
game.board.insert_ball(game.board.column2, game.player2)
game.board.insert_ball(game.board.column1, game.player2)
game.board.insert_ball(game.board.column3, game.player1)
game.board.insert_ball(game.board.column3, game.player2)
game.board.insert_ball(game.board.column3, game.player1)
game.board.insert_ball(game.board.column3, game.player2)
game.board.insert_ball(game.board.column4, game.player1)
game.board.insert_ball(game.board.column4, game.player1)
game.board.insert_ball(game.board.column1, game.player1)
game.board.insert_ball(game.board.column4, game.player2)
game.board.insert_ball(game.board.column4, game.player1)
game.board.insert_ball(game.board.column5, game.player2)
game.board.insert_ball(game.board.column5, game.player2)
game.board.insert_ball(game.board.column5, game.player1)
game.board.insert_ball(game.board.column5, game.player1)
game.board.insert_ball(game.board.column5, game.player1)
game.board.insert_ball(game.board.column6, game.player1)
game.board.insert_ball(game.board.column6, game.player1)
game.board.insert_ball(game.board.column6, game.player1)
game.board.insert_ball(game.board.column6, game.player2)
game.board.insert_ball(game.board.column6, game.player2)
game.board.insert_ball(game.board.column6, game.player2)
game.board.display_board
# p game.board.check_upper_right
# p game.diagonals_right_to_left
game.check_for_win
