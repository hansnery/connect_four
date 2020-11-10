# frozen_string_literal: true

# :nodoc:
class ConnectFour
  require_relative 'board'

  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    puts 'Welcome to Connect Four!'
    @board.display_board
    create_players
    @game_over = false
    run_game
  end

  def create_players
    puts "\nPlease, insert name of Player 1:"
    player1_name = gets.chomp
    @player1 = Player.new('white', player1_name)
    puts "\nPlease, insert name of Player 2:"
    player2_name = gets.chomp
    @player2 = Player.new('black', player2_name)
    puts "\n#{@player1.name} will play as White and #{@player2.name} will play as Black!\n\n"
  end

  def run_game
    while @game_over == false
      play_turn(@player1) if @game_over == false
      play_turn(@player2) if @game_over == false
    end
  end

  def play_turn(player)
    puts "\n#{player.name}'s Turn!\nInsert number of the column to put a ball:"
    play = check_input
    if @game_over == false
      @board.insert_ball(@board.columns[play.to_i - 1], player)
      @board.display_board
      check_for_win
    end
  end

  def check_input
    input = gets.chomp
    if input =~ /\A[1-7]\z/
      input
    elsif input == 'exit'
      @game_over = true
    else
      puts "Try a number between 1 and 7 or type 'exit' to leave the game."
      check_input
    end
  end

  def check_for_win
    check_elements(@board.columns)
    check_elements(@board.lines)
    check_elements(@board.diagonals_left_to_right)
    check_elements(@board.diagonals_right_to_left)
  end

  def check_elements(array)
    white_counter = 0
    black_counter = 0
    array.each do |el|
      break if white_counter > 3 || black_counter > 3

      white_counter = count_balls(el, white_counter, @player1.symbol)
      black_counter = count_balls(el, black_counter, @player2.symbol)
    end
    check_for_winner(white_counter, black_counter)
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

  def check_for_winner(player1_counter, player2_counter)
    if player1_counter > 3
      puts 'White wins!'
      @player1.wins += 1
    end
    if player2_counter > 3
      puts 'Black wins!'
      @player2.wins += 1
    end
    @game_over = true if player1_counter > 3 || player2_counter > 3
  end
end

ConnectFour.new
