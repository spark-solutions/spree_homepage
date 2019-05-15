Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'Add instagram tab',
  insert_bottom: 'ul[data-hook="admin_configurations_sidebar_menu"]',
  text: '<%= configurations_sidebar_menu_item(Spree.t(:instagram), spree.edit_admin_instagram_settings_path) %>'
)
