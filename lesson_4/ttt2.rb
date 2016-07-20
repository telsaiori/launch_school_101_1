require 'pry'
INIT_MAKER = ' '
PLAYER_MAKER = 'X'
COMPUTER_MAKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(board)
  system 'clear'
  puts "You're a #{PLAYER_MAKER}. Computer's #{COMPUTER_MAKER}"
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |   #{board[2]} |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |   #{board[5]} |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |   #{board[8]} |  #{board[9]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INIT_MAKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INIT_MAKER }
end

def player_places_piece(brd)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(brd).join(', ')}) "
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MAKER
end

def computer_places_piece(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MAKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  win_condition = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]
  win_condition.each do |line|
    if brd[line[0]] == brd[line[1]] && brd[line[1]] == brd[line[2]]
      winner = brd[line[0]]
      return "Player" if winner == PLAYER_MAKER
      return "Computer" if winner == COMPUTER_MAKER
    end
  end
  nil
end

loop do
  board = initialize_board

  loop do
    display_board(board)
    player_places_piece(board)
    break if someone_won?(board) || board_full?(board)
    computer_places_piece(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won !"
  else
    prompt "It's a tie!"
  end

  prompt "Play again? (y or n )"
  answer = gets.chomp
  break unless answer.downcase.start_with? "y"
end

prompt "Thanks to play tic tac toe. bye-bye"
