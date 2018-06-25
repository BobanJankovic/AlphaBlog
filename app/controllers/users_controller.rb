class UsersController < ApplicationController

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
            flash[:success] = "Welcome to the alpha blog #{@user.username}"
            redirect_to articles_path
        else render 'new'
        end
    
    end
    def edit #display form for the existing method,template
        @user = User.find(params[:id])
    
    end
    def update 
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:notice] = "User was successfully updated"
            redirect_to articles_path
        else
            render 'edit'
        end
    
    end
    def show
        @user = User.find(params[:id])
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    
    end
    
    def user_params
        params.require(:user).permit(:username, :email, :password)
       end

end