class Admin::UsersController < Admin::BaseController
  before_action :find_user
  
  def show
    @admin_events = @user.admin_events  
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: "Les informations de l'utilisateur ID:#{@user.id} ont bien été mises à jour !"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, success: "Le compte de l'utilisateur ID:#{@user.id} a été supprimé avec succès."
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end  
end