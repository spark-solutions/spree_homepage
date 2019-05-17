Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'add_home_page_tab_to_main_menu',
  insert_bottom: "[data-hook='admin_tabs']",
  text: '<%= render partial: "spree/admin/shared/home_page_tabs" %>'
)
