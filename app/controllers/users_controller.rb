class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @user = User.find(params[:id])
    unless is_author?(@user)
      flash[:danger] = "Vous n'êtes pas le propriétaire de ce profil d'utilisateur !"
      redirect_back(fallback_location: root_path)
    end
    @admin_events = current_user.admin_events
  end

  
end
