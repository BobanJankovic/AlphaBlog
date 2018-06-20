class ArticlesController < ApplicationController
    http_basic_authenticate_with name: "bobivankenobi", password: "bobicar92", except: [:index, :show]
    before_action :set_article, only: [:edit, :update, :show, :destroy]
def index
    @article=Article.all
end


def new
    @article=Article.new
end

def create
    #render plain: params[:article].inspect
    @article=Article.new(article_params)
    @article.user = User.first
    if @article.save
        flash[:notice] = "Article was successfully created"
        redirect_to article_path(@article)
    else render 'new'
    end

end
def show
    
end

def destroy
   
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end

  def edit #display form for the existing method,template
    
end
  def update
    
        if @article.update_attributes(article_params)
            flash[:notice] = "Article was successfully updated"
            redirect_to articles_path
        else
            render 'edit'
        end
  end


 private
 def set_article

    @article = Article.find(params[:id])
    
    end
 def article_params
 params.require(:article).permit(:title, :description)
end



end