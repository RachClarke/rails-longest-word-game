require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # raise
    @answer = params[:word]
    @result = calculate_result
  end

  def word_in_grid?(answer, grid)
    answer_letters = answer.upcase.chars
    answer_letters.all? { |letter| answer_letters.count(letter) <= grid.gsub(' ', '').count(letter) }
  end

  def english_word?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    result = JSON.parse(open(url).read)
    result['found']
  end

  def calculate_result
    unless word_in_grid?(params[:word], params[:grid])
      return "Sorry but #{params[:word]} can't be built out of #{params[:grid]}"
    end
    unless english_word?(params[:word])
      return "Sorry but #{params[:word]} doesn't seem to be a valid English word..."
    end

    "Congratulations #{params[:word]} is a valid English word!"
  end
end
