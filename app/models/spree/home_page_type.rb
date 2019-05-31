module Spree
  class HomePageType < Spree::Base
    belongs_to :home_page_section_type
    belongs_to :home_page_field_type
  end
end
