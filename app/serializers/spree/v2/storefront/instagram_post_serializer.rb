module Spree
  module V2
    module Storefront
      module InstagramPostHelper
        def hashtag_data(post)
          post_data = JSON.parse(post.data)
          post_data.merge({
            owner: {
              name: post.instagram_user.name,
              username: post.instagram_user.username,
              profile_picture_url: post.instagram_user.image&.image_url,
            }
          })
        end
      end

      class InstagramPostSerializer < BaseSerializer
        extend InstagramPostHelper
        set_type :instagram_post
        belongs_to :product
        attribute :data do |post|
          post.hashtag_id != nil && post.instagram_user ? hashtag_data(post) : JSON.parse(post.data)
        end
      end
    end
  end
end
