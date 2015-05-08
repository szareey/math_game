require 'byebug'
@player_lives = {1=> 3, 2=> 3} 
@player_turn = 1

def generate_question
  operator = ['+', '-', '*'].sample
  num1 = rand(20)
  num2 = rand(20)
  ans = num1.method(operator).(num2)
  question = "What does #{num1} #{operator.to_s} #{num2} = ?"
  q_and_a = {q: question, a: ans}
end

def print_question_intro()
  puts <<-QUESTION_INTRO
   --------------------------
  | Player #{@player_turn}, it is your turn |
   --------------------------
  ready? Press ENTER!
  QUESTION_INTRO
  gets.chomp
end

def check_lives(player_id)
  @player_lives[player_id] -= 1 
  lives_left = @player_lives[player_id]
  puts "You have #{lives_left} lives left"
  if lives_left == 0
    puts "PLAYER #{player_id%2 + 1} WINS!"
    return lives_left
  end
end

def next_round (q_a)
  print_question_intro()
  puts q_a[:q]
    if gets.chomp.to_i == q_a[:a]
      puts "========="
      puts "CORRECT!!"
      puts "========="
    else
      puts "WRONG!!, the correct answer was #{q_a[:a]}"
      return if check_lives(@player_turn) == 0
    end
    @player_turn = (@player_turn % 2) + 1  #Toggle player turns
    next_round(generate_question)
end

puts next_round(generate_question)



