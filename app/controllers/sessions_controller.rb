class SessionsController < ApplicationController
  def new
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authentiate(params[:session][:passwor])
    else 
      render :new
    end
  end
  
  def create
    render :new
  end
end
