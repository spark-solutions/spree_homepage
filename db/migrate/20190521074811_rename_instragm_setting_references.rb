class RenameInstragmSettingReferences < ActiveRecord::Migration[5.2]
  def change
    rename_column :spree_instagram_posts, :spree_instagram_setting_id, :instagram_setting_id
  end
end
