Deface::Override.new(
  virtual_path: "spree/layouts/spree_application",
  name: "auth_shared_login_bar",
  insert_bottom: "[data-hook='inside_head']",
  partial: "spree/shared/login_bar_items",
  disabled: false,
  original: 'c00d67dfc0496d21a351b48c41a728412cb5ed2c'
)
