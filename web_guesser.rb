require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
# @@guesses_remaining = 5

def check_guess(guess)
  if guess.nil?
    return ""
  elsif guess.to_i > SECRET_NUMBER + 5
    return ["Waaaaay too high", "#FF0000"]
  elsif guess.to_i < SECRET_NUMBER - 5
    return ["Waaaaaay too low", "#CC3300"]
  elsif guess.to_i > SECRET_NUMBER
    return ["Too high", "#FE8387"]
  elsif guess.to_i < SECRET_NUMBER
    return ["Too low", "#DB704D"]
  else
    ["You guessed the secret number!!! It WAS #{SECRET_NUMBER}", "#85E685"]
  end
end

# def reset_number
#   @@guesses_remaining = 5
#   SECRET_NUMBER = rand(101)
# end
#
# def bad_guess
#   @@guesses_remaining -= 1
#   if @@guesses_remaining.zero?
#     reset_number
#     return ["You used up all your guesses!! The game will be reset.", "FF6600"]
#   end
# end

get '/' do
  guess = params["guess"]
  message, background = check_guess(guess)
  x = erb :index, :locals => {:guess => guess, :message => message, :background => background}

end
