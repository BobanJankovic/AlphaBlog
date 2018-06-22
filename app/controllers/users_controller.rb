class UsersController < ApplicationController
    def new
        @user=User.new
    end
    def create
        #render plain: params[:article].inspect
        @user=User.new(user_params)
       
        if @user.save
            flash[:notice] = "User was successfully created"
            redirect_to articles_path
        else render 'new'
        end
    
    end
    
    def user_params
        params.require(:user).permit(:username, :email, :password)
       end

end