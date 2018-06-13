class ArticlesController < ApplicationController
    http_basic_authenticate_with name: "bobivankenobi", password: "bobicar92", except: [:index, :show]
def index
    @article=Article.all
end

def new
    @article=Article.new
end

def create
    #render plain: params[:article].inspect
    @article=Article.new(article_params)
    if @article.save
        flash[:notice] = "Article was successfully created"
        redirect_to article_path(@article)
    else render 'new'
    end

end
def show
    @article=Article.find(params[:id])
end

def destroy
    @article=Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def edit #display form for the existing method,template
    @article=Article.find(params[:id])
end
  def update
    @article=Article.find(params[:id])
        if @article.update_attributes(article_params)
            redirect_to articles_path
        else
            render 'new'
        end
  end


 private
 def article_params
 params.require(:article).permit(:title, :description)
end



end