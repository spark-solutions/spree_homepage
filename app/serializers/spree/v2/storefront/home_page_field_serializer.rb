module Spree
  module V2
    module Storefront
      class HomePageFieldSerializer < BaseSerializer
        set_type :home_page_field

        attributes :name, :title, :field_type, :content
        belongs_to :home_page_section
      end
    end
  end
end
