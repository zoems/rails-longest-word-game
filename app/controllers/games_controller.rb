require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def start
    params[:guess] ? @guess = params[:guess] : @guess = ""
    @grid = generate_grid
    @included = included?(@guess, params[:grid])
    @check = english_word?(@guess)
  end

  private

  def generate_grid
    # TODO: generate random grid of letters
    @grid = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    @check = json['found']
  end

  def included?(guess, grid)
    guess.upcase.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
