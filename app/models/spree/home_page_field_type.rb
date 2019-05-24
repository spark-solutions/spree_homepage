module Spree
  class HomePageFieldType < ApplicationRecord
    FIELDS = %i[
      text
      image
    ].freeze

    has_many :home_page_fields
    has_many :home_page_types
    has_many :home_page_section_types, through: :home_page_types

    validates :name, presence: true, uniqueness: true
    validates :field_type, presence: true
  end
end
