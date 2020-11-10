# frozen_string_literal: true

# :nodoc:
class Board
  require_relative 'player'

  attr_reader :empty_tile, :column1, :column2, :column3, :column4, :column5, :column6, :column7

  def initialize
    @empty_tile = '  '
    @column1 = [@empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile]
    @column2 = [@empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile]
    @column3 = [@empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile]
    @column4 = [@empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile]
    @column5 = [@empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile]
    @column6 = [@empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile]
    @column7 = [@empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile, @empty_tile]
    @columns = [@column1, @column2, @column3, @column4, @column5, @column6, @column7]
    define_colors
  end

  def define_colors
    @white = '⚪'
    @black = '⚫'
  end

  def display_board
    i = 5
    6.times do
      first_half = "[#{@column1[i]}][#{@column2[i]}][#{@column3[i]}][#{@column4[i]}]"
      second_half = "[#{@column5[i]}][#{@column6[i]}][#{@column7[i]}]"
      string = first_half + second_half
      puts string
      i -= 1
    end
  end

  def insert_ball(column, player)
    column.each_with_index do |el, idx|
      if el == @empty_tile
        column[idx] = player.symbol
        break
      end
    end
    @lines = @columns.transpose
  end

  def check_for_win
    check_elements(@columns)
    check_elements(@lines)
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

  def create_diagonals(column_to_check = 0, next_element_to_check = 0, result = [])
    (0..5).collect do |i|
      column = i + column_to_check
      break if column > 6

      el = @columns[i + column_to_check][i + next_element_to_check]
      result << el unless el.nil?
    end
    result
  end

  def check_lower_right(result = [])
    i = 3
    3.times do
      diagonal = create_diagonals(i)
      i -= 1
      result << diagonal
    end
    result
  end

  def check_upper_left(result = [])
    i = 0
    3.times do
      diagonal = create_diagonals(0, 0 + i)
      i += 1
      result << diagonal
    end
    result
  end

  def diagonals_right_to_left(result = [])
    check_lower_right.map do |i|
      result << i
    end
    check_upper_left.map do |i|
      result << i
    end
    result
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

board = Board.new
player1 = Player.new('white', 'Player One')
player2 = Player.new('black', 'Player Two')
board.insert_ball(board.column1, player1)
board.insert_ball(board.column2, player2)
board.insert_ball(board.column2, player2)
board.insert_ball(board.column1, player2)
board.insert_ball(board.column3, player1)
board.insert_ball(board.column3, player2)
board.insert_ball(board.column3, player1)
board.insert_ball(board.column3, player2)
board.insert_ball(board.column4, player1)
board.insert_ball(board.column4, player1)
board.insert_ball(board.column1, player1)
board.insert_ball(board.column4, player2)
board.insert_ball(board.column4, player1)
board.insert_ball(board.column5, player2)
board.insert_ball(board.column5, player2)
board.insert_ball(board.column5, player1)
board.insert_ball(board.column5, player1)
board.insert_ball(board.column5, player1)
board.insert_ball(board.column6, player1)
board.insert_ball(board.column6, player1)
board.insert_ball(board.column6, player1)
board.insert_ball(board.column6, player2)
board.insert_ball(board.column6, player2)
board.insert_ball(board.column6, player2)
board.check_for_win
p board.diagonals_right_to_left
board.display_board
