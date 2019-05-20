module Spree
  module V2
    module Storefront
      class HomePageFieldImageSerializer < BaseSerializer
        set_type :home_page_field_image

        attributes :viewable_type, :viewable_id, :styles
      end
    end
  end
end
