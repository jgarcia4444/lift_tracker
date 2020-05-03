require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_secret"
  end

  get "/" do
    erb :index
  end

  get '/signup' do
    if !is_logged_in?
      @message = session[:message]
      erb :signup
    else
      redirect "users/#{current_user.slug}"
    end
    
  end

  post '/signup' do
    check_params(params, "signup")
    if !User.find_by(username: params[:username])
      username = params[:username]
      pass = params[:password]
      new_user = User.create(username: username, password: pass)
      session.clear
      session[:id] = new_user.id
      redirect "/users/#{new_user.slug}"
    else
      set_session_message("Username #{params[:username]} is already taken, please choose a unique username.")
      redirect '/signup'
    end
   
  end

  get '/login' do
    if !is_logged_in?
      @message = session[:message]
      erb :login
    else
      redirect "users/#{current_user.slug}"
    end
  end

  post '/login' do
    check_params(params, 'login')
    if user = User.find_by(username: params[:username])
      if user.authenticate(params[:password])
        session[:id] = user.id
        redirect "users/#{user.slug}"
      else
        set_session_message("Incorrect Password")
        redirect '/login'
      end
    else
      set_session_message("Username not found")
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  helpers do

    def set_session_message(message)
      session[:message] = message
    end
    
    def is_logged_in?
      session[:id]
    end

    def current_user
      if is_logged_in?
        User.find(session[:id])
      end
    end

    def check_params(params, current_page)

      params.each do |k,v|
        if v.empty?
          set_empty_message("#{k.to_s} cannot be left empty.")
          redirect "/#{current_page}"
        end
      end
    end

    def set_empty_message(message)
      session[:message] = message
    end

  end

end


