class ExpandInstagramPostsHashtagIdSize < ActiveRecord::Migration[5.2]
  def change
    change_column :spree_instagram_posts, :hashtag_id, :bigint
  end
end
