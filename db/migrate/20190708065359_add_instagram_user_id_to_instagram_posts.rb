class AddInstagramUserIdToInstagramPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_instagram_posts, :instagram_user_id, :integer
    add_index :spree_instagram_posts, :instagram_user_id
  end
end
