class AddHomePageFieldTypeIdToHomePageField < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_home_page_fields, :home_page_field_type_id, :integer
    add_index :spree_home_page_fields, :home_page_field_type_id, name: 'index_fields_on_field_type_id'
  end
end
