module Spree
  class HomePageFieldType < ApplicationRecord
    has_many :home_page_fields
    belongs_to :home_page_section_type
  end
end
