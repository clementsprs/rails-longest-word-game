require 'uri'
require 'net/http'
require 'json'
require 'open-uri'



class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }.join
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:try]}"
    response = JSON.parse(URI.open(url).read)
    if response['found'] && check_letters_in_grid?(params[:try], params[:letters])
      @score = "Congratulations, #{params[:try]} is an English word"+ "your score is #{response["length"]}"
    elsif response['found'] && !check_letters_in_grid?(params[:try], params[:letters])
      @score = "Sorry but #{params[:try]} can't be buit out of #{params[:letters]}"
    else
      @score = "Sorry but #{params[:try]} doesn't seem to be an English word"
    end
  end

  def check_letters_in_grid?(word, letters)
    word.chars.all? do |letter|
      word.upcase.count(letter.upcase) <= letters.count(letter.upcase)
    end
  end
end
