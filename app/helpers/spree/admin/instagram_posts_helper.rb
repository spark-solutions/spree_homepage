module Spree
  module Admin
    module InstagramPostsHelper
      def thumbnail_url(post)
        JSON.parse(post.data)['media_url']
      end
    end
  end
end
