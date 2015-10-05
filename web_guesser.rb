require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@guesses_remaining = 5


# Think I can refactor the below...not sure how...
# maybe combine the 2 highs and 2 lows and somehow move the winner functionality
# to it's own method?
def check_guess(guess)
  if guess.nil?
    return ["", "#FFFFFF"]
  else
    turns = guess_decrement
    if guess.to_i > @@secret_number + 5
      return turns.nil? ? ["Waaaaay too high", "#FF0000"] : turns
    elsif guess.to_i < @@secret_number - 5
      return turns.nil? ? ["Waaaaaay too low", "#CC3300"] : turns
    elsif guess.to_i > @@secret_number
      return turns.nil? ? ["Too high", "#FE8387"] : turns
    elsif guess.to_i < @@secret_number
      return turns.nil? ? ["Too low", "#DB704D"]: turns
    else
      correct_answer = @@secret_number
      reset_secret_number
      return ["Winner winner, chicken dinner!<br />
        You guessed the secret number!!! It WAS #{correct_answer}.<br />
        The game has now been reset. Play again!", "#85E685"]
    end
  end
end

def guess_decrement
  @@guesses_remaining -= 1
  if @@guesses_remaining == 0
    reset_secret_number
    return ["Time's Up! The game has been reset", "#8A2EE6"]
  end
end

def reset_secret_number
  @@guesses_remaining = 5
  @@secret_number = rand(101)
end

def cheat_mode(cheater)
  if cheater.nil?
    cheat_message =  ""
  elsif cheater == "true"
    cheat_message = ".....You little rebel, I like you.<br />
    The answer is #{@@secret_number}...shhhhhh"
  else
    cheat_message = "You are trying to cheat, but you suck at it.<br />
    Lame."
  end
end

get '/' do
  guess = params["guess"]
  cheater = params["cheat"]
  message, background = check_guess(guess)
  cheat_message = cheat_mode(cheater)
  x = erb :index, :locals => {:message => message, :background => background, :cheat_message => cheat_message}
end
