class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      flash.now[:danger] = "保存出来ませんでした"
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
    
    #PVインクリメント
    REDIS.zincrby "ranking", 1, @article.id
  end

  def destroy
    @article = Article.find(params[:id])
    
    if @article.destroy
      #PVランキングから削除
      REDIS.zrem "ranking", @article.id

      flash.now[:success] = "投稿を削除しました"
    else
      flash.now[:danger] = "投稿を削除できませんでした"
    end
    
    #@articles = Article.all
    #render 'static_pages/home'
    redirect_to root_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "投稿を更新しました"
    redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end
end
