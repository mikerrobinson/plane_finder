class UsersController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :new, :create ]
    
  def show
    @user = current_user #User.find(params[:id])
  end
  
  # 
  # def new
  #   @user = User.new
  # end
  # 
  # def create
  #   @user = User.new(params[:user])
  #   if @user.save
  #     flash[:success] = t("user.welcome")
  #     redirect_to @user
  #   else
  #     render 'new'
  #   end
  # end
  # 
  # def edit
  #   @user = User.find(params[:id])
  # end
    
    
end
