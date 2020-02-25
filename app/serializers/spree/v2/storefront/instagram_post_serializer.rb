module Spree
  module V2
    module Storefront
      module InstagramPostHelper
        def media_url(blob, base_url)
          Rails.application.routes.url_helpers.rails_blob_url(blob, host: base_url)
        end

        def url_if_attached(media_model, base_url)
          media_model.attached? ? media_url(media_model, base_url) : nil
        end

        def hashtag_data(post, base_url)
          post_data = JSON.parse(post.data)
          post_data.merge({
            owner: {
              name: post.instagram_user.name,
              username: post.instagram_user.username,
              profile_picture_url: post.instagram_user.image&.image_url(base_url),
            },
            media_url: url_if_attached(post.media, base_url)
          })
        end

        def user_data(post, base_url)
          post_data = JSON.parse(post.data)
          post_data.merge({
            media_url: url_if_attached(post.media, base_url),
            owner: post_data["owner"].merge({
              profile_picture_url: url_if_attached(post.profile_picture_media, base_url)
            })
          })
        end
      end

      class InstagramPostSerializer < BaseSerializer
        extend InstagramPostHelper

        set_type :instagram_post
        belongs_to :product
        attribute :data do |post, params|
          base_url = params[:base_url]

          if post.hashtag_id != nil && post.instagram_user
            hashtag_data(post, base_url)
          else
            user_data(post, base_url)
          end
        end
      end
    end
  end
end
