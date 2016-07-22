require 'pry'
# rubocop:disable Style/MutableConstant
INIT_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
# rubocop:enable Style/MutableConstant

WIN_CONDITION = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
# rubocop:disable Style/Next
def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer's #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INIT_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INIT_MARKER }
end

def player_places_piece(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd), ', ', 'or')}) "
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece(brd)
  if ai_offense(brd)
    brd[ai_offense(brd)] = COMPUTER_MARKER
  elsif ai_defense(brd)
    brd[ai_defense(brd)] = COMPUTER_MARKER
  else
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

def ai_offense(brd)
  key = 0
  WIN_CONDITION.each do |line|
    if brd.values_at(*line).count('O') == 2
      if brd.values_at(*line).count(' ') != 0
        key = brd.select { |k, v| line.include?(k) && v == ' ' }.keys.first
        break
      end
    else
      key = nil
    end
  end
  key
end

def ai_defense(brd)
  key = 0
  WIN_CONDITION.each do |line|
    if brd.values_at(*line).count('X') == 2
      if brd.values_at(*line).count(' ') != 0
        key = brd.select { |k, v| line.include?(k) && v == ' ' }.keys.first
        break
      end
    else
      key = nil
    end
  end
  key
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WIN_CONDITION.each do |line|
    if brd[line[0]] == brd[line[1]] && brd[line[1]] == brd[line[2]]
      winner = brd[line[0]]
      return "Player" if winner == PLAYER_MARKER
      return "Computer" if winner == COMPUTER_MARKER
    end
  end
  nil
end

def joinor(arr, delimiter= ', ', word = 'or')
  arr[-1] = "#{word} #{arr.last}"
  arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
end

def result_record(result, scores)
  scores[result.downcase.to_sym] += 1
end

def five_times?(scores)
  if scores[:player] == 1
    return "players"
  elsif scores[:computer] == 1
    return "computer"
  else
    false
  end
end

def place_piece!(board, current_player)
  if current_player == "Player"
    player_places_piece(board)
  else
    computer_places_piece(board)
  end
end

def alternate_player(current_player)
  if current_player == "Player"
    return "Computer"
  else
    return "Player"
  end
end

def go_first(player)
  if player.downcase.start_with?('p')
    return "Player"
  elsif player.downcase.start_with?('c')
    return "Computer"
  else
    puts "Please enter [c]omputer/[p]layer"
    return false
  end
end

loop do
  board = initialize_board
  scores = { player: 0, computer: 0 }
  choose = ""
  prompt "Get 5 points to win"
  loop do
    loop do
      prompt "Who do you want to go first? ([c]omputer/[p]layer)"
      choose = gets.chomp
      break if go_first(choose)
    end
    current_player = go_first(choose)
    board = initialize_board
    loop do
      display_board(board)
      prompt "Get 5 points to win"
      prompt "Your score: #{scores[:player]}"
      prompt "computer's score: #{scores[:computer]}"
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won !"
      result_record(detect_winner(board), scores)
    else
      prompt "It's a tie!"
    end

    if five_times?(scores)
      scores = { player: 0, computer: 0 }
      answer = ''
      loop do
        prompt "Play again? (y or n )"
        answer = gets.chomp
        break if answer.downcase.start_with? "y", "n"
        prompt "Please enter y or n"
      end
      break if answer.downcase.start_with? "n"
    end
  end
  break
end
prompt "Thanks to play tic tac toe. bye-bye"
