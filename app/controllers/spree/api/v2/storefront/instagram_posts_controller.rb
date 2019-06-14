module Spree
  module Api
    module V2
      module Storefront
        class InstagramPostsController < Spree::Api::V2::BaseController
          def index
            resource = params[:user] ? user_posts : hashtag_posts
            render_serialized_payload { serialize_resource(resource) }
          end

          private

          def user_posts
            Spree::InstagramPost.user.where(show: true)
          end

          def hashtag_posts
            Spree::InstagramPost.hashtag.where(show: true)
          end

          def resource_serializer
            Spree::V2::Storefront::InstagramPostSerializer
          end

          def serialize_resource(resource)
            resource_serializer.new(
              resource,
              include: ['product.default_variant']
            ).serializable_hash
          end
        end
      end
    end
  end
end
