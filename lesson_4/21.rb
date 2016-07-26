require 'pry'
SUITS = %w(h d c s).freeze
VALUES = %w(2 3 4 5 6 7 8 9 10 j q k a).freeze

def prompt(msg)
  puts "=> #{msg}"
end

def init_deck
  SUITS.product(VALUES).shuffle
end

def count(cards)
  sum = 0
  values = cards.map { |card| card[1] }
  values.each do |value|
    if value == 'a'
      sum += 11
    elsif value.to_i == 0 # l,q,k
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == 'a' }.count.times do
    sum -= 10 if sum > 21
  end
  sum
end

def busted?(count)
  count > 21
end

def winner(player_total, dealer_total)
  if player_total > 21
    "Player_busted"
  elsif dealer_total > 21
    "dealer_busted"
  elsif player_total > dealer_total
    "player"
  elsif dealer_total > player_total
    "dealer"
  else
    "Tie"
  end
end

def display_result(result)
  case result
  when "Player_busted"
    prompt "You busted! Dealer wins!"
  when "dealer_busted"
    prompt "Dealer busted! You win!"
  when "player"
    prompt "You win!"
  when "dealer"
    prompt "Dealer wins!"
  when "Tie"
    prompt "It's a Tie!"
  end
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

loop do
  prompt "Welcome to Twenty-One!"
  deck = init_deck
  player_deck = []
  dealer_deck = []

  2.times do
    player_deck << deck.pop
    dealer_deck << deck.pop
  end

  player_total = count(player_deck)
  dealer_total = count(dealer_deck)

  prompt "Dealer has #{dealer_deck[0]} and ?"
  prompt "You have: #{player_deck[0]} and #{player_deck[1]}, for a total of #{count(player_deck)}."

  loop do
    if busted?(player_total)
      prompt("Busts!!")
      break
    end
    puts prompt("(h)it or (s)tay?")
    answer = gets.chomp
    if answer.downcase.start_with? 'h'
      prompt "You want to hit"
      player_deck << deck.pop
      prompt "you have #{player_deck} now"
      player_total = count(player_deck)
      prompt "Your total is #{player_total}"
    end
    break if answer.downcase.start_with? 's' || busted?(player_total)
  end

  prompt "This is your final deck #{player_deck}"

  prompt "Dealder turn.."

  loop do
    if dealer_total <= 17
      prompt "Dealer hits!"
      dealer_deck << deck.pop
      dealer_total = count(dealer_deck)
      prompt "Dealer's cards are now: #{dealer_deck}"
    end
    break if dealer_total >= 17 || busted?(dealer_total)
  end

  puts "=============="
  prompt "Dealer has #{dealer_deck}, for a total of: #{count(dealer_deck)}"
  prompt "Player has #{player_deck}, for a total of: #{count(player_deck)}"
  puts "=============="

  display_result winner(player_total, dealer_total)
  break unless play_again?
end

prompt "Thank you for playing Twenty-One! Good bye!"
