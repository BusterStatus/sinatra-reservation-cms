class ReservationsController < ApplicationController

    get '/reservations' do
        if logged_in?
            @reservations = Reservation.all
            erb :'reservations/index'
        else
            redirect to '/login'
        end
    end

    get '/reservations/new' do
        if logged_in?
            erb :'reservations/new'
        else
            redirect to '/login'
        end
    end

    post '/reservations' do
        if params[:name] == "" || params[:date] == "" || params[:resource] == "" || params[:contact] == ""
            flash[:blank_fields] = "No fields can be left blank."
            redirect to '/reservations/new'
        else
            @reservation = Reservation.create(name: params[:name], date: params[:date], contact: params[:contact], resource: params[:resource]  , user_id: session[:user_id])
            flash[:reservation_success] = "Reservation successful."
            redirect "/reservations/#{@reservation.id}"
        end
    end


    get '/reservations/:id' do
        if logged_in?
            @reservation = Reservation.find(params[:id])
            if current_user.id == @reservation.user_id
                erb :'/reservations/show'
            else
                redirect "/users/#{current_user.slug}"
                flash[:unauthorized] = "You do not have access to this page."
            end
        else
          redirect '/login'
        end
    end

    get '/reservations/:id/edit' do
        if logged_in?
            @reservation = Reservation.find(params[:id])
            erb :'/reservations/edit'
        else
          redirect '/login'
        end
    end

    get '/reservations/:id/edit' do
        @user = User.find_by(id: session[:user_id])
        if !@user.nil?
            @tweet = Tweet.find(params[:id])
            erb :'/reservations/edit'
        else
            redirect '/login'
        end
    end

    patch '/reservations/:id' do
        @tweet = Tweet.find(params[:id])
        if @tweet
            if params[:content] != ""

                @tweet.update(content: params[:content])
                redirect "/reservations/#{@tweet.id}"
            else
                redirect "/reservations/#{@tweet.id}/edit"
            end
        end
    end

    delete '/reservations/:id' do
        @user = User.find_by(id: session[:user_id])
        if !@user.nil?
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == session[:user_id]
                @tweet.delete
                redirect '/reservations'
            end
        else
            redirect '/login'
        end
    end
end