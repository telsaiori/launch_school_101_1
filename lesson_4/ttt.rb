require 'pry'

def display_board(board)
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

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' '}
  new_board
end

def player_turn(player, board)
  if board[player] == " "
    board[player] = "x"
    display_board(board)
    true
  else
    puts "Please choice valid square"
    false
  end
end

def computer_turn(board)
  loop do
    rand = rand(1..9)
    if board[rand] == " "
      board[rand] = "o"
      display_board(board)
      break
    end
  end
end

def winner?(board)
  win_condition = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]+
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]]+
                  [[1, 5, 9], [3, 5, 7]]

  win_condition.each do |line|
    if board[line[0]] == board[line[1]] &&  board[line[1]] == board[line[2]]
      winner = board[line[0]]
    end
    return "Player" if winner == "x"
    return "Computer" if winner == "o"
  end
  false
end

def full_board?(board)
  board.has_value? " "
end


puts "Welcome to the Tic Tac Toe game"
puts "o for computer, x for the player"
board = initialize_board
display_board(board)
loop do 
  loop do 
    puts "Please make your choice, enter 1~9"
    player = gets.chomp.to_i
    # puts "#{winner?(board)} win the games" 
    break if player_turn(player, board)
  end
  # binding.pry
  
  if winner?(board)
    puts "#{winner?(board)} wins"
    break
  end

  unless full_board?(board)
    puts "Tie"
    break
  end

  puts "Now it's computer's turn"
  computer_turn(board)
  winner?(board)
  
end
