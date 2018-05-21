class ArticlesController < ApplicationController

    before_action :set_article, only: [:edit, :update, :show, :destroy]

    def index
        @articles = Article.paginate(page: params[:page],per_page: 5)
    end

    def new 
        @article = Article.new
    end

    def edit
        # @article = Article.find(params[:id])
    end

    def create
        # byebug
        # render plain: params[:article].inspect
        @article = Article.new(article_params)

        #temporaty User id for article
        @article.user = User.last


        if @article.save
            flash[:success] = "Articles was successfully created"
            redirect_to article_path(@article)

        else
            # render :new (same as below)
            render 'new'
        end
    end

    def update
        # @article = Article.find(params[:id])

        if @article.update(article_params)
            flash[:success] = "Articles was successfully Updated"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end

    def show
        # @article = Article.find(params[:id])
    end

    def destroy
        # @article = Article.find(params[:id])
        @article.destroy

        flash[:danger] = "Articles was successfully Destroyed"
        redirect_to articles_path
    end


    private
    def set_article 
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    
    end
end
