class AddHomePageSectionTypeIdToHomePageSection < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_home_page_sections, :home_page_section_type_id, :integer
    add_index :spree_home_page_sections, :home_page_section_type_id, name: 'index_sections_on_section_type_id'
  end
end
