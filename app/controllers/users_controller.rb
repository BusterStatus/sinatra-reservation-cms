class UsersController < ApplicationController

    get '/' do
        redirect to '/login'
    end

    get '/signup' do
        if logged_in?
            flash[:signed_up] = "You already have an account and are logged in."
            redirect to "/users/#{current_user.slug}"
        else
          erb :'/users/signup'
        end
    end

    post '/signup' do
        if params[:password] == params[:password_confirmation] && params[:email] == params[:email_confirmation]
            user = User.create(name: params[:name], username: params[:username].downcase, email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation])
            session[:user_id] = user.id
            flash[:new_account_success] = "Account creation successful.  You are now logged in."
            redirect to "/users/#{user.slug}"
        elsif !(params[:password] != params[:password_confirmation])
            flash[:password_mismatch] = "Passwords do not match.  Please try again."
            erb :'/users/signup'
        elsif !(params[:email] != params[:email_confirmation])
            flash[:email_mismatch] = "Email addresses do not match.  Please try again."
            erb :'/users/signup'
        elsif User.find_by(email: params[:email])
            flash[:email_already_in_use] = "An account with this email address already exists.  Please try again."
            erb :'/users/signup'
        elsif User.find_by(username: params[:username])
            flash[:username_already_in_use] = "An account with this username already exists.  Please try again."
            erb :'/users/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect to "/users/#{current_user.slug}"
        else
          erb :'/users/login'
        end
    end
    
    post '/login' do
        user = User.find_by(:email => params[:email])
        if user.try(:authenticate, params[:password]) 
            session[:user_id] = user.id
            redirect to "/users/#{current_user.slug}"
        else
            flash[:login_failure] = "Email or password did not match our records.  Please try again."
            redirect "/login"
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to '/login'
        else
          erb :'/users/login'
        end
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            reservations = Reservation.all
            @reservations = reservations.sort_by { |reservation| reservation.date }
            erb :'/users/show'
        else
            flash[:view_account_failure] = "You must be logged in to view your account page."
            redirect to '/login'
        end
    end

end