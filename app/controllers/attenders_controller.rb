class AttendersController < ApplicationController

    configure do
      enable :sessions
      set :session_secret, "password_security"
    end
  
    get '/attenders' do
      if logged_in?
        @attenders = current_user.attenders
        erb :'/attenders/index'
      else
        login_redirect
      end
    end
  
    get "/attenders/new" do
      if logged_in?
        erb :'/attenders/new'
      else
        login_redirect
      end
    end
  
    get "/attenders/:id/edit" do
      if logged_in? && @attenders = current_user.attenders.find_by(id: params[:id])
        erb :'/attenders/edit'
      else
        session[:message] = "Sorry, this attender is not accessible!"
        redirect '/event'
      end
    end
  
    post "/attenders" do
      if logged_in? && params[:name] != ""
        Attender.create(name: params[:name], role: params[:role], rsvp: params[:rsvp], event_id: current_user.event.id)
        redirect "/attenders"
      elsif params[:name] == ""
        session[:message] = "Name is required."
        redirect "/attenders/new"
      else
        login_redirect
      end
    end
  
    post "/attenders/:id" do
      @attender = current_user.guests.find_by(id: params[:id])
      if logged_in? && params[:name] != ""
        @attender.update(name: params[:name], role: params[:role], rsvp: params[:rsvp])
        redirect "/attenders/#{@attender.id}"
      elsif params[:name] == ""
        session[:message] = "Name is required."
        redirect "/attenders/#{@attender.id}/edit"
      else
        login_redirect
      end
    end
  
    get '/attenders/:id' do
      if logged_in? && @attender = current_user.attenders.find_by(id: params[:id])
        erb :'/attenders/show'
      else
        session[:message] = "Sorry, this attender is not accessible!"
        redirect '/event'
      end
    end
  
    delete '/attenders/:id/delete' do
      @attender = current_user.attenders.find_by(id: params[:id])
      if logged_in? && @attender.destroy
        session[:message] = "The attender has been deleted."
        redirect '/attenders'
      else
        login_redirect
      end
    end
  
  end