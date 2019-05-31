class AddProductIdToInstagramPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_instagram_posts, :product_id, :integer
    add_index :spree_instagram_posts, :product_id
  end
end
