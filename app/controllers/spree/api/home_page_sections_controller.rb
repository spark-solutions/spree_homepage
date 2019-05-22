module Spree
  module Api
    module V2
      class HomePageSectionsController < Spree::Api::V2::BaseController
        def index
          render_serialized_payload { serialize_resource(resource) }
        end

        private

        def resource
          Spree::HomePageSection.includes(:home_page_fields)
        end

        def resource_serializer
          Spree::V2::Storefront::HomePageSectionSerializer
        end

        def serialize_resource(resource)
          resource_serializer.new(
            resource,
            include: [:home_page_fields]
          ).serializable_hash
        end
      end
    end
  end
end
