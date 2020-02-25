module Spree
  module Admin
    module InstagramPostsHelper
      def instagram_data(post)
        JSON.parse(post.data)
      end

      def instagram_link(post, content)
        link_to content, instagram_data(post)["permalink"]
      end

      def instagram_preview(post)
        return image_tag(main_app.url_for(post.media.representation(resize: "100x100"))) if post.media.attached? && post.media.representable?

        Spree.t(:no_preview)
      end
    end
  end
end
