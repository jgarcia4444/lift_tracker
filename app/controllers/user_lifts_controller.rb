class UserLiftsController < ApplicationController

    get '/user-lifts/new' do
        @message = session[:message]
        @lift_types = LiftType.all
        erb :'user_lifts/new'
    end

    post '/user-lifts' do
        
        check_lift_params(params)
        weight_input_check(params[:weight])

        UserLift.create(:weight => params[:weight], :lift_type_id => params[:lift_type], :user_id => current_user.id)
        redirect "/users/#{current_user.slug}"
    end

    helpers do
        def check_lift_params(params)
            params.each do |k, v|
                if v.empty?
                    deslugged_key = deslug_key(key)
                    set_session_message("#{deslugged_key} cannot be left empty")
                    redirect "/user-lifts/new"
                end
            end
        end
        def delug_key(key)
            key_array = key.split("_")
            key_array.join(" ")
        end
    end

    def weight_input_check(weight_value)
        if weight_value.to_i < 0
            set_session_message("The value of weight must be a positive integer.")
            redirect "/user-lifts/new"
        end
    end

end