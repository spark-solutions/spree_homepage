module Spree
  module Admin
    module InstagramPostsHelper
      def thumbnail_url(post)
        JSON.parse(post.data)['images']['thumbnail']['url']
      end
    end
  end
end
