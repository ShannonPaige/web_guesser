require 'sinatra'           # ~> LoadError: cannot load such file -- sinatra
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

def check_guess(guess)
  if guess.nil?
    return ""
  elsif guess.to_i > SECRET_NUMBER + 5
    return "Waaaaay too high"
  elsif guess.to_i < SECRET_NUMBER - 5
    return "Waaaaaay too low"
  elsif guess.to_i > SECRET_NUMBER
    return "Too high"
  elsif guess.to_i < SECRET_NUMBER
    return "Too low"
  else
    "You guessed the secret number!!! It WAS #{SECRET_NUMBER}"
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  x = erb :index, :locals => {:guess => guess, :message => message}

end

# ~> LoadError
# ~> cannot load such file -- sinatra
# ~>
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/shannonpaige/code/web_guesser/web_guesser.rb:1:in `<main>'
