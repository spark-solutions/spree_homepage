module Spree
  class HomePageSection < ApplicationRecord
    acts_as_list

    has_many :home_page_fields

    validates :title, presence: true
    validates :title, uniqueness: true
    validates :name, uniqueness: true

    before_save :assign_name

    private

    def assign_name
      self.name = title.parameterize.underscore
    end
  end
end
