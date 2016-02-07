require 'sinatra/base'
require './lib/player'
require './lib/game'
require './lib/computer'


class RPS < Sinatra::Base

  enable :sessions

  get '/' do
    erb(:index)
  end

  post '/name' do
    $game = Game.new(Player.new(params[:Player_1]), Computer.new)
    redirect to '/play'
  end

  get '/play' do
    @player_1_name = $game.player_1.name
    erb(:play)
  end

  post '/choices' do
    @game = $game
    @game.player_1.make_choice(params['choice'])
    # @game.computer.rps_choice
    @game.rps_logic(@game.player_1.choice, @game.computer.choice)
    redirect to '/results'
  end

  get '/results' do
    @game = $game
    @game.result
    erb(:results)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
