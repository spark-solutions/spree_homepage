module Spree
  module Api
    module V2
      class InstagramPostsController < Spree::Api::V2::BaseController
        def index
          render_serialized_payload { serialize_resource(resource) }
        end

        private

        def resource
          Spree::InstagramPost.where(show: true)
        end

        def resource_serializer
          Spree::V2::Storefront::InstagramPostSerializer
        end

        def serialize_resource(resource)
          resource_serializer.new(
            resource
          ).serializable_hash
        end
      end
    end
  end
end
