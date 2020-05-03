require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :session
  end

  get "/" do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    check_params(params, "signup")
    username = params[:username]
    pass = params[:password]
    new_user = User.create(username: username, password: pass)
    redirect "/users/#{new_user.slug}"
  end

  helpers do
    
    def is_logged_in?
      if session[:id]
        return true
      end
      return false
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


