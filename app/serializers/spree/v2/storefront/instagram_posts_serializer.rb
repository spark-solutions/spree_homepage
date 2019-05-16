module Spree
  module V2
    module Storefront
      class InstagramPostsSerializer < BaseSerializer
        set_type :instagram_posts
        attributes :data do |post|
          JSON.parse(post.data)
        end
      end
    end
  end
end
