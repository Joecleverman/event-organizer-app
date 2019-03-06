class ContractorsController < ApplicationController

    configure do
      enable :sessions
      set :session_secret, "password_security"
    end
  
    get '/contractors' do
      if logged_in?
        @contractors = current_user.contractors
        erb :'/contractors/index'
      else
        login_redirect
      end
    end
  
    get "/contractors/new" do
      if logged_in?
        erb :'/contractors/new'
      else
        login_redirect
      end
    end
  
    get "/contractors/:id/edit" do
      if logged_in? && @contractor = current_user.contractors.find_by(id: params[:id])
        erb :'/contractors/edit'
      else
        session[:message] = "This contractor is not accessible!"
        redirect '/event'
      end
    end
  
    post "/contractors" do
      if logged_in? && params[:name] != "" && valid_cost(params[:cost])
        Contractor.create(name: params[:name], title: params[:title], cost: params[:cost].to_i, event_id: current_user.event.id)
        redirect "/contractors/#{Contractor.last.id}"
      elsif params[:name] == "" 
        session[:message] = "Name is required."
        redirect "/contractors/new"
      elsif !valid_cost(params[:cost])
        session[:message] = "Cost must be greater or equal to zero."
        redirect "/contractors/new"
      else
        login_redirect
      end
    end
  
    post "/contractors/:id" do
      @contractor = current_user.contractors.find_by(id: params[:id])
      if logged_in? && params[:name] != "" && valid_cost(params[:cost])
        @contractor.update(name: params[:name], title: params[:title], cost: params[:cost], event_id: current_user.event.id)
        redirect "/contractors/#{@contractor.id}"
      elsif params[:name] == ""
        session[:message] = "Name is required."
        redirect "/contractors/#{@contractor.id}/edit"
      elsif !valid_cost(params[:cost])
        session[:message] = "Cost must be greater or equal to zero."
        redirect "/contractors/#{@contractor.id}/edit"
      else
        login_redirect
      end
    end
  
    get '/contractors/:id' do
      if logged_in? && @contractor = current_user.contractors.find_by(id: params[:id])
        erb :'/contractors/show'
      else
        session[:message] = "This contractor is not accessible!"
        redirect '/event'
      end
    end
  
    delete '/contractors/:id/delete' do
      @contractor = current_user.contractors.find_by(id: params[:id])
      if logged_in? && @contractor.destroy
        session[:message] = "The contractor has been deleted."
        redirect '/vendors'
      else
        login_redirect
      end
    end
  
    helpers do
      def valid_cost(cost)
        if cost.to_i.to_s == cost && cost.to_i >= 0
          return true
        else
          return false
        end
      end
    end
  
  end