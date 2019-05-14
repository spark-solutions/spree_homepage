class Spree::HomePageField < ApplicationRecord
  belongs_to :home_page_section

  validates_presence_of :title
  validates_uniqueness_of :title, :name

  before_create :assign_name

  private

  def assign_name
    self.name = title.tr!(' ', '_')
  end
end
