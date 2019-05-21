class Spree::HomePageField < ApplicationRecord
  FIELDS = %i[
    text
    image
  ].freeze

  belongs_to :home_page_section
  has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::HomePageFieldImage'

  validates_presence_of :title, :field_type
  validates_uniqueness_of :title, :name

  before_save :assign_name

  private

  def assign_name
    self.name = self.title.parameterize.underscore
  end
end
