class RemoveFieldTypeFromHomePageFields < ActiveRecord::Migration
  def change
    remove_column :spree_home_page_fields, :field_type, :string
  end
end
