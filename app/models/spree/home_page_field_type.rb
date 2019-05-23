module Spree
  class HomePageFieldType < ApplicationRecord
    FIELDS = %i[
      text
      image
    ].freeze

    has_many :home_page_fields
    belongs_to :home_page_section_type

    validates :field_type, presence: true
  end
end
