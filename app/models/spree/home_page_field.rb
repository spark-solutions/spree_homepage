module Spree
  class HomePageField < Spree::Base
    belongs_to :home_page_section
    belongs_to :home_page_field_type
    has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::HomePageFieldImage'

    validates :name, presence: true, uniqueness: true

    before_validation :assign_name

    private

    def assign_name
      self.name = title.parameterize.underscore if name.blank?
    end
  end
end
