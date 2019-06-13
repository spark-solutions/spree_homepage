class RenameInstagramSettingsColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :spree_instagram_settings, :target_account, :hashtag_id
    rename_column :spree_instagram_settings, :code, :user_id
    add_column :spree_instagram_settings, :hashtag, :string, null: false, default: ''
  end
end
