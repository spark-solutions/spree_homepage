module Spree
  module Admin
    class HomePageSectionsController < ResourceController
      before_action :section_types, only: %i[new edit]

      def index
        @home_page_sections = Spree::HomePageSection.order(position: :asc)
      end

      private

      def section_types
        @section_types ||= Spree::HomePageSectionType.all
      end
    end
  end
end
