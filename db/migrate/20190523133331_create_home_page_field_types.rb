class CreateHomePageFieldTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_home_page_field_types do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.references :home_page_section_type, index: { name: 'index_field_types_on_section_type_id' }
      t.timestamps
    end
  end
end
