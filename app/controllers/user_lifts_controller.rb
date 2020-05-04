class UserLiftsController < ApplicationController

    get '/user-lifts/new' do
        @lift_types = LiftType.all
        erb :'user_lifts/new'
    end

    post '/user-lifts' do
        
    end

end