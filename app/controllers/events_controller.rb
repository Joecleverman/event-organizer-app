class EventsController < ApplicationController

    configure do
      enable :sessions
      set :session_secret, "password_security"
    end
  
    get '/event' do
      if logged_in?
        if @event = current_user.event
          erb :'/event/show'
        else
          erb :'/event/index'
        end
      else
        login_redirect
      end
    end
  
    delete '/event/delete' do
      if logged_in?
        @event = current_user.event
        @event.destroy
        session[:message] = "The event has been deleted."
        redirect '/event'
      else
        login_redirect
      end
    end
  
    get '/event/new' do
      if logged_in? && !current_user.event
        erb :'/event/new'
      elsif current_user.event
        session[:message] = "Only one event per account is allowed."
        redirect '/event'
      else
        login_redirect
      end
    end
  
    post '/event' do
      if logged_in? && params[:name] != ""
        Event.create(name: params[:name], location: params[:location], date: params[:date], user_id: current_user.id)
        redirect "/event"
      elsif params[:name] == ""
        session[:message] = "Name is required."
        redirect "/event/new"
      else
        login_redirect
      end
    end
  
    get "/event/edit" do
      if logged_in?
        @event = current_user.event
        erb :'/event/edit'
      else
        login_redirect
      end
    end
  
    post "/event/edit" do
      if logged_in? && params[:name] != ""
        @event = current_user.event
        @event.update(name: params[:name], location: params[:location], date: params[:date])
        redirect "/event"
      elsif params[:name] == ""
        session[:message] = "Name is required."
        redirect "/event/edit"
      else
        login_redirect
      end
    end
  
  end