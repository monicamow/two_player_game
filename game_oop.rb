#Your program will still have to keep 
#track of whose turn it is, and check 
#players' scores and lives.
require 'pry-byebug'

require_relative 'player'


@current_player = 0

# REPL
def run_game
  @playing = true
  # MENU
  puts "| Welcome to the 'Math Game' | \
  \nPlayer 1, please enter your name: "

  user_input = gets.chomp.strip
  @player1 = Player.new(user_input)
  puts "Hello, #{@player1.name}!"

  puts "\nPlayer 2, please enter your name: "
  user_input = gets.chomp.strip
  @player2 = Player.new(user_input)
  puts "Hello, #{@player2.name}!"

  puts "(1) Enter 'play' to play the game. \
  \n    A random player will be chosen to answer the first question. \
  \n(2) Enter 'quit' to quit at any time."
  
  while @playing do
    user_input = gets.chomp.strip

    case user_input
      when "play"
        pick_who_starts
      when /\d/
        verify_answer(user_input)
        determine_current_player
        generate_question
        game_over
      when "quit"
        @playing = false
      when "yes"
        @player1.lives = 3
        @player2.lives = 3
        @player1.points = 0
        @player2.points = 0
        pick_who_starts
      when "no"
        @playing = false
      else
        puts "Answer the question or type 'quit'."

    end

  end

end

# generate random math questions
def generate_question()
  @array = [rand(1..20),rand(1..20)]
  @operation = rand(1..4)
  #array_negative = [rand(-20..-1),rand(-20..-1)]

  question = "---> What is #{@array[0]} #{operation_to_string} #{@array[1]}?\n"

  puts question
end

# pick who goes first
def pick_who_starts()
  @current_player = rand(1..2)

  if @current_player == 2
    puts "\nThe first question is for #{@player2.name}:\n"
  else
    puts "\nThe first question is for #{@player1.name}:\n"
  end
  generate_question
end

def operation
  case @operation
  when 1
    @array[0] + @array[1]
  when 2
    @array[0] - @array[1]  
  when 3
    @array[0] * @array[1] 
  when 4
    @array[0] / @array[1] 
  end
end

def operation_to_string
  case @operation
  when 1
    "+"
  when 2
    "-"
  when 3
    "*"
  when 4
    "/"
  end
end

# verify answer
def verify_answer(answer)
  answer = answer.to_i
    if answer == operation
      puts "\nCORRECT!"
      @player1.gain_a_point if @current_player == 1
      @player2.gain_a_point if @current_player == 2
      puts "---> #{@player1.name} points: #{@player1.points}"
      puts "---> #{@player2.name} points: #{@player2.points}"
    else
      puts "\nINCORRECT!"
      @player1.lose_a_life if @current_player == 1
      @player2.lose_a_life if @current_player == 2
      puts "---> #{@player1.name} lives: #{@player1.lives}"
      puts "---> #{@player2.name} lives: #{@player2.lives}"
    end

end

# next player
def determine_current_player
  if @current_player == 2
    @current_player = 1
    puts "\nThis question is for #{@player1.name}:\n"
  else
    @current_player = 2
    puts "\nThis question is for #{@player2.name}:\n"
  end
end  

# GAME OVER
def game_over()
  if @player1.lives == 0 or @player2.lives == 0
    puts "\nWOMP WOMP. GAME OVER."
    puts "---> #{@player1.name} wins!!!" if @player2.lives == 0
    puts "---> #{@player2.name} wins!!!" if @player1.lives == 0
    puts "\nPLAY AGAIN? (yes/no)"
  elsif @player1.points == 5 or @player2.points == 5
    puts "\nWOMP WOMP. GAME OVER."
    puts "---> #{@player1.name} wins!!!" if @player1.points == 5
    puts "---> #{@player2.name} wins!!!" if @player2.points == 5
    puts "\nPLAY AGAIN? (yes/no)"

  end

end

run_game