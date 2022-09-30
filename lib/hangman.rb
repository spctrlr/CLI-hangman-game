class Hangman
  DICTIONARY = ["train station", "airplane", "bootcamp", "ship"]
  
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []

    @secret_word.each_char.with_index { |c, i| indices << i if @secret_word[i] == char }

    indices
  end

  def fill_indices(char, arr)
    arr.each { |i| @guess_word[i] = char }
  end

  def try_guess(char)
    # if that character is been used already, do nothing.
    if already_attempted?(char)
      puts "that has already been attempted"
      return false
    end

    # if character is not been already attempted and is matching
    @attempted_chars << char

    # find the matching index/s of that character from the secret word 
    mached_indices = get_matching_indices(char)
    # fill guess_word with the character/s for matched index/s
    fill_indices(char, mached_indices)

    # if there is no match with the given character(count it as wrong guess)
    @remaining_incorrect_guesses -= 1 if mached_indices.empty?

    # return true to indicate that character was not previously attempted
    true
  end

  def ask_user_for_guess
    puts "Enter a char: "
    try_guess(gets.chomp)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    # if game is lost or won
    if self.win? || self.lose?
      puts "The secret word was: #{@secret_word}"
      return true
    else
      # if game is not lost or won
      return false
    end
  end
end
