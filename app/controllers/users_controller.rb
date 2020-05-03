class UsersController < ApplicationController

  # GET: /users
  get "/users" do
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
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:slug" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:slug/delete" do
    redirect "/users"
  end
end
