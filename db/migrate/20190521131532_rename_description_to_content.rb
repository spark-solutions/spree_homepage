class RenameDescriptionToContent < ActiveRecord::Migration[5.2]
  def change
    rename_column :spree_home_page_fields, :description, :content
  end
end
