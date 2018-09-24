class Article < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  def get_page_view
    REDIS.zscore("ranking", "#{self.id}")
  end
end
