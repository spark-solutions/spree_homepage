class Spree::HomePageSection < ApplicationRecord
  has_many :home_page_fields

  validates_presence_of :title
  validates_uniqueness_of :title, :name

  before_save :assign_name

  private

  def assign_name
    self.name = self.title.parameterize.underscore
  end
end
