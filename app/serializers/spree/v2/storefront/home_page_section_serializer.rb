module Spree
  module V2
    module Storefront
      class HomePageSectionSerializer < BaseSerializer
        set_type :home_page_section

        attributes :name, :title, :visible, :mobile_visible, :position
        attribute :type do |section|
          section.home_page_section_type&.name
        end

        has_many :home_page_fields
      end
    end
  end
end
