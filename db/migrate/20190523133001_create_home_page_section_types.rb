class CreateHomePageSectionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_home_page_section_types do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
