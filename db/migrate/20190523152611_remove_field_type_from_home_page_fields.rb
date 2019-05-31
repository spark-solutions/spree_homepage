class RemoveFieldTypeFromHomePageFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :spree_home_page_fields, :field_type, :string
  end
end
