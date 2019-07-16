module Spree
  module Admin
    module InstagramPostsHelper
      def instagram_data(post)
        JSON.parse(post.data)
      end

      def instagram_link(post, content)
        link_to content, instagram_data(post)["permalink"]
      end

      def instagram_thumbnail(post)
        data = instagram_data(post)
        tag = data["media_type"] == "VIDEO" ? :video : :img
        content_tag(tag, nil, src: data["media_url"], class: "thumbnail")
      end
    end
  end
end
