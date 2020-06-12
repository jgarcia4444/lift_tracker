require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "#{SecureRandom.hex}"
  end

  get "/" do
    if is_logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :index
    end
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
      new_user = User.create(params)
      clear_session_and_set_id(new_user)
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
      login_authentication(user, params[:password])
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

    def login_authentication(user, possible_password)
      if user.authenticate(possible_password)
        clear_session_and_set_id(user)
        redirect "users/#{user.slug}"
      else
        set_session_message("Incorrect Password")
        redirect '/login'
      end
    end

    def clear_session_and_set_id(user)
        session.clear
        session[:id] = user.id
    end

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
          set_session_message("#{k.to_s.split("_").join(" ").capitalize} cannot be left empty.")
          redirect "/#{current_page}"
        end
      end
    end

    def validate_access(logged_in_user, user_to_be_edited)
      if logged_in_user == user_to_be_edited
        return true
      else 
        return false
      end
    end

  end

end


