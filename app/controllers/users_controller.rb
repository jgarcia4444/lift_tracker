class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    @users = User.all
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:slug/edit" do
    @message = session[:message]
    @user = User.find_by_slug(params[:slug])
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    check_params(params, "users/#{@user.slug}/edit")
    if current_user == @user 
      @user.update(:username => params[:new_username])
    end
    redirect "/users/#{@user.slug}"
  end

  get "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    if current_user == @user
      erb :'users/delete.html'
    else
      redirect "/users/#{@user.slug}"
    end
  end

  # DELETE: /users/5/delete
  delete "/users/:slug/delete" do
    redirect "/users"
  end
end
