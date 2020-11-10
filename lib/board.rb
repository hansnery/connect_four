# frozen_string_literal: true

# :nodoc:
class Board
  require_relative 'player'

  attr_reader :empty_tile, :column1, :column2, :column3, :column4, :column5, :column6, :column7, :columns, :lines

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
    puts '  1 - 2 - 3 - 4 - 5 - 6 - 7'
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

  def create_diagonals(column_to_check = 0, next_element_to_check = 0, result = [], right_to_left = false)
    (0..5).collect do |i|
      break if column_to_check + i > 6 && right_to_left == false
      break if (column_to_check - i).negative? && right_to_left == true

      el = @columns[column_to_check + i][next_element_to_check + i] if right_to_left == false
      el = @columns[column_to_check - i][next_element_to_check + i] if right_to_left == true
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

  def diagonals_left_to_right(result = [])
    check_lower_right.map do |i|
      result << i
    end
    check_upper_left.map do |i|
      result << i
    end
    result
  end

  def check_lower_left(result = [])
    i = 0
    4.times do
      diagonal = create_diagonals(3 + i, 0, [], true)
      i += 1
      result << diagonal
    end
    result
  end

  def check_upper_right(result = [])
    i = 0
    2.times do
      diagonal = create_diagonals(6, 1 + i, [], true)
      i += 1
      result << diagonal
    end
    result
  end

  def diagonals_right_to_left(result = [])
    check_lower_left.map do |i|
      result << i
    end
    check_upper_right.map do |i|
      result << i
    end
    result
  end
end
