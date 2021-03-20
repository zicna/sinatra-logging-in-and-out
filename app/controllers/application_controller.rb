require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/account'
    else 
      #binding.pry
      erb :error
    end
    
  end

  get '/account' do
    #@user = User.find_by(session[:user_id])
    #binding.pry
    #&& Helper.is_logged_in?(session)
    @user = User.find_by_id(session[:user_id])
    #binding.pry   
    if @user 
      #binding.pry
      erb :account
    else
      erb :error
    end
     
    
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end

