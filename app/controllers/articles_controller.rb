class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "投稿しました"
      redirect_to root_path
    else
      flash.now[:alert] = "投稿出来ませんでした"
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
    
    #PVインクリメント
    REDIS.zincrby "ranking", 1, @article.id
  end

  def destroy
    #@article = Article.find(params[:id])
    
    if @article.destroy
      #PVランキングから削除
      REDIS.zrem "ranking", @article.id

      flash.now[:notice] = "投稿を削除しました"
    else
      flash.now[:alert] = "投稿を削除できませんでした"
    end
    
    #@articles = Article.all
    #render 'static_pages/home'
    redirect_to root_path
  end

  def edit
    #before_action correct_user
  end

  def update
    #@article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "記事を更新しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id]) #current_userの記事を取得し、params[:id]の記事があれば取得

      if @article.nil?                                          #current_userの記事でなければrootに戻る
        flash[:alert] = "この投稿の作成者でないと編集・削除はできません"
        redirect_to root_path
      end

    end
end
