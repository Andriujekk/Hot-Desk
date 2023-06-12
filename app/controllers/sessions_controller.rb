class SessionsController < ApplicationController
   def new
  end

  def create
    if params[:login].present? && params[:password].present?
      user = User.find_by(login: params[:login])
  
      if user && user.password == params[:password]
        session[:user_id] = user.id
        # flash[:notice] = 'Logged in successfully.'
        redirect_to desks_path
      else
        # flash.now[:alert] = 'Invalid login credentials.'
        redirect_to login_path
      end
    else
      # flash.now[:alert] = 'Missing login parameter.'
      redirect_to login_path

    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private 
  def sessions_params
    params.require(:session).permit(:login, :password)
  end
end
