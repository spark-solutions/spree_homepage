module Spree
  class HomePageSectionType < Spree::Base
    has_many :home_page_types
    has_many :home_page_field_types, through: :home_page_types
    has_many :home_page_sections

    validates :name, presence: true, uniqueness: true
  end
end
