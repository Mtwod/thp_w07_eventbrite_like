class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :find_user
  before_action :redirect_not_author
  
  def show
    @admin_events = current_user.admin_events
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: "Vos informations ont bien été mises à jour !"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, success: "Votre compte a été supprimé avec succès."
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def redirect_not_author
    unless is_author?(@user)
      flash[:danger] = "Vous n'êtes pas le propriétaire de ce compte !!"
      redirect_back(fallback_location: root_path)
    end
  end
end
