class ReservationsController < ApplicationController

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
            @reservation = Reservation.create(name: params[:name], date: params[:date], contact: params[:contact], resource: params[:resource], user_id: session[:user_id])
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
            if current_user.id == @reservation.user_id
                erb :'/reservations/edit'
            else
                redirect "/users/#{current_user.slug}"
                flash[:unauthorized] = "You do not have access to this page."
            end
        else
          redirect '/login'
        end
    end

    patch '/reservations/:id' do
        @reservation = Reservation.find(params[:id])
        if @reservation
            if params[:name] == "" || params[:date] == "" || params[:resource] == "" || params[:contact] == ""
                flash[:blank_fields] = "No fields can be left blank."
                redirect "/reservations/#{@reservation.id}/edit"
            else

                @reservation.update(name: params[:name], date: params[:date], contact: params[:contact], resource: params[:resource])
                flash[:reservation_update_success] = "Reservation updated successfully."
                redirect "/reservations/#{@reservation.id}"
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