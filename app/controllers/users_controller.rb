class UsersController < ApplicationController

  get "/users" do
    @users = User.all
    erb :"/users/index.html"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show.html"
  end

  get "/users/:slug/edit" do
    @message = session[:message]
    @user = User.find_by_slug(params[:slug])
    if validate_access(current_user, @user)
      erb :"/users/edit.html"
    else
      redirect '/users'
    end
  end

  patch "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    check_params(params, "users/#{@user.slug}/edit")
    if validate_access(current_user, @user)
      @user.update(:username => params[:new_username])
      redirect "/users/#{@user.slug}"
    else
      redirect '/users'
    end
  end

  get "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    if validate_access(current_user, @user)
      erb :'users/delete.html'
    else
      redirect "/users"
    end
  end

  delete "/users/:slug/delete" do
    if validate_access(current_user, User.find_by_slug(params[:slug]))
      current_user.destroy
      session.clear
      redirect "/"
    else
      redirect "/users/#{params[:slug]}/delete"
    end
  end

end
