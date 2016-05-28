# Initialize
@player1_lives = 3
@player2_lives = 3

@player1_points = 0
@player2_points = 0

@current_player = 0

# REPL
def run_game
  @playing = true
  # MENU
  puts "| Welcome to the 'Math Game' | \
  \n(1) Enter 'play' to play the game. \
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

      else
        puts "Answer the question or type 'quit'."

    end

  end

end

# pick who goes first
def pick_who_starts()
  @current_player = rand(1..2)
  puts "\nPlayer #{@current_player} gets to start:"
  generate_question
end

# generate random math questions
def generate_question()
  @array = [rand(1..20),rand(1..20)]
  #array_negative = [rand(-20..-1),rand(-20..-1)]

  question = "---> What is #{@array[0]} + #{@array[1]}?\n"

  puts question
end

# CODE FOR RANDOMZING ADDITION AND SUBTRACTION

  # # add numbers if rand(num) = 0
  # def add(number1,number2)
  #   number1 + number2
  # end

  # # subtract numbers if rand(num) = 1
  # def add(number1,number2)
  #   number1 - number2
  # end

# verify answer
def verify_answer(answer)
  answer = answer.to_i
    if answer == @array[0] + @array[1]
      puts "\nCORRECT!"
      @player1_points += 1 if @current_player == 1
      @player2_points += 1 if @current_player == 2
      puts "---> Player 1 points: #{@player1_points}"
      puts "---> Player 2 points: #{@player2_points}"
    else
      puts "\nINCORRECT!"
      @player1_lives -= 1 if @current_player == 1
      @player2_lives -= 1 if @current_player == 2
      puts "---> Player 1 lives: #{@player1_lives}"
      puts "---> Player 2 lives: #{@player2_lives}"
    end

end

# next player
def determine_current_player
  if @current_player == 2
    @current_player = 1
  else
    @current_player = 2
  end
  puts "\nPlayer #{@current_player} is next:\n"
end  

# CODE TO REFACTOR LOSING LIVES / GAINING POINTS
# AND FOR POSTING REMAINING LIVES / CURRENT POINTS

# deduct life
def lose_life()
  # if player_x answer = true
    # do nothing
  # else
    # deduct 1 live

end

# post "score"
def post_score()
  # if lose life changes
    # post new score
  # else
    # do nothing, move to next question

end

# GAME OVER
def game_over()
  if @player1_lives == 0 or @player2_lives == 0
    @playing = false
    puts "\nWOMP WOMP. GAME OVER."
    puts "---> Player 1 wins!!!" if @player2_lives == 0
    puts "---> Player 2 wins!!!" if @player1_lives == 0
  elsif @player1_points == 5 or @player2_points == 5
    @playing = false
    puts "\nWOMP WOMP. GAME OVER."
    puts "---> Player 1 wins!!!" if @player1_points == 5
    puts "---> Player 2 wins!!!" if @player2_points == 5
  end
end

run_game