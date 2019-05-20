module Spree
  module Api
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
    end
  end
end
