class Spree::HomePageField < ApplicationRecord
  FIELDS = %i[
    text
    image
  ].freeze

  belongs_to :home_page_section

  validates_presence_of :title, :field_type
  validates_uniqueness_of :title, :name

  before_create :assign_name

  private

  def assign_name
    self.name = title.tr!(' ', '_')
  end
end
