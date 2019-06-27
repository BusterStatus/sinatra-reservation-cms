class UsersController < ApplicationController

    get '/' do
        redirect to '/login'
    end

    get '/signup' do
        if logged_in?
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
            @reservations = Reservation.all
            erb :'/users/show'
        else
            redirect to '/login'
        end
    end

end