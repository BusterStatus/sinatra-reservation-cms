class ReservationsController < ApplicationController

    get '/reservations' do
        if logged_in?
            erb :'reservations/index'
        else
            redirect to '/login'
        end
    end

end