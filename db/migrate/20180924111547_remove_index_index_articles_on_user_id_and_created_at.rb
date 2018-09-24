class RemoveIndexIndexArticlesOnUserIdAndCreatedAt < ActiveRecord::Migration[5.2]
  def change
    remove_index :articles,name: :index_articles_on_user_id_and_created_at
  end
end
