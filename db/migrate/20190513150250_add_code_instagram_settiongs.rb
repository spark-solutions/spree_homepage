class AddCodeInstagramSettiongs < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_instagram_settings, :code, :string, null: false, default: ''
  end
end
