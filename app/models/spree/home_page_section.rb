module Spree
  class HomePageSection < ApplicationRecord
    acts_as_list

    has_many :home_page_fields

    validates :title, presence: true
    validates :name, presence: true, uniqueness: true

    before_validation :assign_name

    private

    def assign_name
      self.name = title.parameterize.underscore if name.blank?
    end
  end
end
