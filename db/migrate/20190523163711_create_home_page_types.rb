class CreateHomePageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_home_page_types do |t|
      t.references :home_page_section_type
      t.references :home_page_field_type
    end
  end
end
