class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
  end

  def is_admin?
    unless current_user.is_admin
      redirect_to root_path, danger: "Vous n'êtes pas administrateur de ce site !"
    end
  end
end