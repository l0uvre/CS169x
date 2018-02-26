class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # setters and getters
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  # def instance_method guess
  def guess(letter)
    if letter =~ /[^a-zA-Z]/ or letter == nil or letter.length == 0
      raise ArgumentError, "invalid parameters" 
    end
    letter = letter.downcase
    if self.guesses.include? letter or self.wrong_guesses.include? letter
      return false
    end
    if self.word.include? letter
      self.guesses += letter
    else 
      self.wrong_guesses += letter
    end
    return true
  end
  
  # def instance_mathod to display the incomplete word
  def word_with_guesses
    display = ''
    self.word.each_char do |char|
      if self.guesses.include? char
        display += char
      else
        display += '-'
      end
    end
    display
  end
  
  def check_win_or_lose
    if self.word_with_guesses.eql? self.word
      return :win
    elsif self.wrong_guesses.length < 7
      return :play
    else
      return :lose
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
