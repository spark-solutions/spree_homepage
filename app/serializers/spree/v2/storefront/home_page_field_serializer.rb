module Spree
  module V2
    module Storefront
      class HomePageFieldSerializer < BaseSerializer
        set_type :home_page_field

        attributes :name, :title, :field_type, :content, :image
        attribute :image do |field|
          field.image&.styles
        end

        has_one :home_page_field_image, id_method_name: :image_id
        belongs_to :home_page_section
      end
    end
  end
end
