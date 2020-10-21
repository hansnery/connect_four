# frozen_string_literal: true

require './lib/board.rb'
require './lib/player.rb'

describe Board do
  describe '#initialize' do
    it 'board initialized' do
      board = Board.new
      expected_array = Array.new(6, board.empty_tile)
      expect(board.column1).to eql expected_array
      expect(board.column2).to eql expected_array
      expect(board.column3).to eql expected_array
      expect(board.column4).to eql expected_array
      expect(board.column5).to eql expected_array
      expect(board.column6).to eql expected_array
      expect(board.column7).to eql expected_array
    end
  end
end

describe Board do
  describe '#check_for_win' do
    board = Board.new
    player1 = Player.new('white', 'Player One')
    player2 = Player.new('black', 'Player Two')
    board.insert_ball(board.column1, player1)
    board.insert_ball(board.column1, player1)
    board.insert_ball(board.column1, player2)
    board.insert_ball(board.column1, player2)
    board.insert_ball(board.column1, player2)
    board.insert_ball(board.column1, player2)
    it 'black can win filling a column' do
      expect(board.check_for_win).to eql 'black'
    end
  end
end

describe Board do
  describe '#check_for_win' do
    board = Board.new
    player1 = Player.new('white', 'Player One')
    player2 = Player.new('black', 'Player Two')
    board.insert_ball(board.column2, player1)
    board.insert_ball(board.column2, player1)
    board.insert_ball(board.column2, player2)
    board.insert_ball(board.column2, player2)
    board.insert_ball(board.column2, player2)
    board.insert_ball(board.column2, player2)
    it 'black can win filling another column' do
      expect(board.check_for_win).to eql 'black'
    end
  end
end

describe Board do
  describe '#check_for_win' do
    board = Board.new
    player1 = Player.new('white', 'Player One')
    player2 = Player.new('black', 'Player Two')
    board.insert_ball(board.column1, player1)
    board.insert_ball(board.column1, player1)
    board.insert_ball(board.column1, player1)
    board.insert_ball(board.column1, player1)
    board.insert_ball(board.column1, player2)
    board.insert_ball(board.column1, player2)
    it 'white can win filling a column' do
      expect(board.check_for_win).to eql 'white'
    end
  end
end

describe Board do
  describe '#check_for_win' do
    board = Board.new
    player1 = Player.new('white', 'Player One')
    player2 = Player.new('black', 'Player Two')
    board.insert_ball(board.column3, player1)
    board.insert_ball(board.column3, player1)
    board.insert_ball(board.column3, player1)
    board.insert_ball(board.column3, player1)
    board.insert_ball(board.column3, player2)
    board.insert_ball(board.column3, player2)
    it 'white can win filling another column' do
      expect(board.check_for_win).to eql 'white'
    end
  end
end

describe 'Playing methods' do
  describe '#insert_ball' do
    it 'inserts one ball' do
      board = Board.new
      player = Player.new('white', 'Player One')
      board.insert_ball(board.column1, player)
      expect(board.column1[0]).to eql player.symbol
    end
    it 'inserts more than one ball' do
      board = Board.new
      player = Player.new('white', 'Player One')
      board.insert_ball(board.column1, player)
      board.insert_ball(board.column1, player)
      board.insert_ball(board.column1, player)
      expect(board.column1[0]).to eql player.symbol
    end
  end
end

describe Player do
  describe '#initialize' do
    it 'player 1 initialized' do
      player_one = Player.new('white', 'Player One')
      expect(player_one.symbol).to eql '⚪'
    end
    it 'player 2 initialized' do
      player_two = Player.new('black', 'Player Two')
      expect(player_two.symbol).to eql '⚫'
    end
  end
end
