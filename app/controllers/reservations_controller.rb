class ReservationsController < ApplicationController

    get '/reservations' do
        if logged_in?
            reservations = Reservation.all
            @reservations = reservations.sort_by { |reservation| reservation.date }
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
        elsif params[:date] < Time.now
            flash[:no_past_reservations] = "You cannot make a reservation for a past date."
            redirect to '/reservations/new'
        else
            @reservation = Reservation.new(name: params[:name], date: params[:date], contact: params[:contact], resource: params[:resource], user_id: session[:user_id])
            if @reservation.save
                flash[:reservation_success] = "Reservation successful."
                redirect "/reservations/#{@reservation.id}"
            else
                flash[:reservation_failure] = "Selected resource already reserved on the chosen day.  Please try again."
                redirect to '/reservations/new'
            end
        end
    end


    get '/reservations/:id' do
        if logged_in?
            @reservation = Reservation.find(params[:id])
            if current_user.id == @reservation.user_id
                erb :'/reservations/show'
            else
                flash[:unauthorized] = "You do not have access to this page."
                redirect "/users/#{current_user.slug}"
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
                flash[:unauthorized] = "You cannot view a reservation created by another user."
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
            elsif params[:date] < Time.now
                flash[:no_past_reservations] = "You cannot make a reservation for a past date."
                redirect to "/reservations/#{@reservation.id}"
            else
                if @reservation.update(name: params[:name], date: params[:date], contact: params[:contact], resource: params[:resource])
                    flash[:reservation_success] = "Reservation successful."
                    redirect "/reservations/#{@reservation.id}"
                else
                    flash[:reservation_failure] = "Selected resource already reserved on the chosen day.  Please try again."
                    redirect to "/reservations/#{@reservation.id}/edit"
                end
            end

            
        end
    end

    delete '/reservations/:id' do
        if logged_in?
            reservation = Reservation.find(params[:id])
            if reservation.user_id == session[:user_id]
                reservation.delete
                flash[:reservation_delete_success] = "Reservation deleted successfully."
                redirect "/users/#{current_user.slug}"
            end
        else
            redirect '/login'
        end
    end

    delete '/reservations' do
        if logged_in?
            Reservation.all.each do |reservation|
                if reservation.user_id == session[:user_id]
                    reservation.delete
                end
            end
            flash[:reservation_delete_all_success] = "All reservations deleted successfully."
            redirect "/users/#{current_user.slug}"
        else
            redirect '/login'
        end
    end
end