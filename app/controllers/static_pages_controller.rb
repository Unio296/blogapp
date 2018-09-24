class StaticPagesController < ApplicationController
  before_action :get_ranking
  
  def home
    @articles = Article.all
    #debugger
  end

  private
  
    #ranking記事を取得
    def get_ranking
      @ids = REDIS.zrevrangebyscore "ranking", "+inf", 0, limit: [0, 5], withscores: true

    end
end
