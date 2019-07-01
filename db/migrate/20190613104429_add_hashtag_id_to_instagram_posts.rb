class AddHashtagIdToInstagramPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_instagram_posts, :hashtag_id, :integer
    add_index :spree_instagram_posts, :hashtag_id
  end
end
