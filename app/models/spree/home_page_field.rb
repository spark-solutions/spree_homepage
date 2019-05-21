class Spree::HomePageField < ApplicationRecord
  FIELDS = %i[
    text
    image
  ].freeze

  belongs_to :home_page_section
  has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::HomePageFieldImage'

  validates :title, presence: true
  validates :name, presence: true, uniqueness: true
  validates :field_type, presence: true

  before_validation :assign_name

  private

  def assign_name
    self.name = title.parameterize.underscore if name.blank?
  end
end
