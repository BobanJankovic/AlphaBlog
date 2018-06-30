class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy, :edit]

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def new
    @user=User.new
  end

  def create
    #render plain: params[:article].inspect
    @user=User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
      else render 'new'
    end
  end

  def edit #display form for the existing method,template
  end

  def update 
    if @user.update_attributes(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User andall articles created by user have been deleted"
    redirect_to users_path
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform this action"
      redirect_to root_path
    end
  end

end