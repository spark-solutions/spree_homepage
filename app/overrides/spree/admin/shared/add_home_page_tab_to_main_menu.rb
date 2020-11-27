Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'add_home_page_tab_to_main_menu',
  insert_bottom: 'nav',
  partial: 'spree/admin/shared/homepage_tabs'
)
