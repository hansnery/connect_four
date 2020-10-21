# frozen_string_literal: true

# :nodoc:
class Player
  attr_reader :name, :symbol
  attr_accessor :wins

  def initialize(color, name = 'Player One')
    @name = name
    @wins = 0
    @symbol = '⚪' if color == 'white'
    @symbol = '⚫' if color == 'black'
  end
end
