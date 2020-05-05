class UserLiftsController < ApplicationController

    get '/user-lifts/new' do
        @message = session[:message]
        @lift_types = LiftType.all
        erb :'user_lifts/new'
    end

    get '/user-lifts/:id/edit' do
        @user_lift = UserLift.find(params[:id])
        @lift_types = LiftType.all
        if current_user == @user_lift.user
            erb :'user_lifts/edit.html'
        else
            redirect "/users"
        end
    end

    post '/user-lifts' do
        
        check_params(params, "user-lifts/new")
        weight_input_check(params[:weight], "user-lifts/new")
        if !params.has_key?(:lift_type)
            set_session_message("An option needs to be selected for the lift type")
            redirect "/user-lifts/new"
        end

        UserLift.create(:weight => params[:weight], :lift_type_id => params[:lift_type], :user_id => current_user.id)
        redirect "/users/#{current_user.slug}"
    end

    patch "/user-lifts/:id/edit" do
        
    end

    helpers do
        def deslug_key(key)
            key_array = key.split("_")
            key_array.join(" ")
        end
    end

    def weight_input_check(weight_value, current_page)
        if weight_value.to_i < 0
            set_session_message("The value of weight must be a positive integer.")
            redirect "/#{current_page}"
        end
    end

end