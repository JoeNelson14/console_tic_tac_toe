# frozen_string_literal: true

module WinLines
  WIN_LINES = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ].freeze
end

# main class
class Game
  include WinLines
  def initialize(player1, player2)
    @board = %w[1 2 3 4 5 6 7 8 9]
    @winner = false
    @player1 = player1.new('player 1', 'X')
    @player2 = player2.new('player 2', 'O')
  end

  def play
    current_player = 'player 1'
    print_board
    # loops game
    while @winner == false
      if current_player == 'player 1'
        selection = @player1.user_input # gets user selection number
        update_board(selection, @player1.marker)
        @winner = player1_winner?
        puts "\n\n#{current_player} has won!" if @winner == true
        current_player = 'player 2'
      else
        selection = @player2.user_input
        update_board(selection, @player2.marker)
        @winner = player2_winner?
        puts "\n\n#{current_player} has won!" if @winner == true
        current_player = 'player 1'
      end
      if tie? == true
        @winner = true
        puts "\n\nTIE GAME!"
      end
      print_board
    end
  end

  def print_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts '--+---+---'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts '--+---+---'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def player1_winner?
    WIN_LINES.any? { |array| array.all? { |spot| @board[spot - 1] == @player1.marker } }
  end

  def player2_winner?
    WIN_LINES.any? { |array| array.all? { |spot| @board[spot - 1] == @player2.marker } }
  end

  def tie?
    @board.all? { |num| (num == @player1.marker || num == @player2.marker) && @winner == false }
  end

  def update_board(selection, marker)
    @board.map! { |num| num == selection ? marker : num }
  end
end

# player class
class Player
  def initialize(user, marker)
    @user = user
    @marker = marker
  end

  attr_reader :marker

  def user_input
    print "#{@user} enter a number to place #{@marker} at that location: "
    gets.chomp
  end
end

Game.new(Player, Player).play
