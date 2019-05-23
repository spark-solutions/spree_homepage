module Spree
  class HomePageSectionType < ApplicationRecord
    has_many :home_page_types
    has_many :home_page_field_types, through: :home_page_types
    has_many :home_page_sections
  end
end
