Spree::StoreController.class_eval do
  def account_link
    render partial: 'spree/shared/login_bar_items'
    fresh_when(spree_current_user)
  end
end
