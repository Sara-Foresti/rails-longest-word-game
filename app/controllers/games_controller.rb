class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters].split("")
    # we need to compare @guess with the @letters that the user saw
    # we need to access that @letters
    # The word can't be built out of the original grid
    # The word is valid according to the grid, but is not a valid English word
    # The word is valid according to the grid and is an English word
    compute_score(@guess, @letters)
    # raise
  end

  private

  def compute_score(guess, letters)
    if english_word?(@guess) && included?(guess, letters)
      @score = 10
    else
      @score = 0
    end
  end

  def english_word?(word)
    require "open-uri"
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    # raise
    return json['found']
  end

  def included?(guess, letters)
    guess.split("").all? do |letter|
      guess.count(letter) <= letters.count(letter)
    end
  end
end


# API endpoint "https://wagon-dictionary.herokuapp.com/:word"
