class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @user = User.find(params[:id])
    unless is_author?(@user)
      flash[:danger] = "Vous n'êtes pas le propriétaire de ce compte !"
      redirect_back(fallback_location: root_path)
    end
    @admin_events = current_user.admin_events
  end

  def edit
    @user = User.find(params[:id])
    unless is_author?(@user)
      redirect_to current_user, danger: "Vous n'éditerez pas ! Car vous n'êtes pas le propriétaire de ce compte !"
    end
  end

  def update
    @user = User.find(params[:id])

    if is_author?(@user)
      if @user.update(user_params)
        redirect_to @user, success: "Vos informations ont bien été mises à jour !"
      else
        render :edit
      end
    else
      redirect_to user_path(params[:id]), danger: "Voouus ne mettrez à jour PAAS !! Car vous n'êtes pas le propriétaire de ce compte !"
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end
end
