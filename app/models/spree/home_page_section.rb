module Spree
  class HomePageSection < ApplicationRecord
    acts_as_list

    has_many :home_page_fields
    belongs_to :home_page_section_type

    validates :name, presence: true, uniqueness: true

    before_validation :assign_name

    private

    def assign_name
      self.name = title.parameterize.underscore if name.blank?
    end
  end
end
