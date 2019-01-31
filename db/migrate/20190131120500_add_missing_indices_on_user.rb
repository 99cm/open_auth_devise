class AddMissingIndicesOnUser < ActiveRecord::Migration[5.2]
  def change
    unless index_exists?(:spree_users, :bill_address_id)
      add_index :spree_users, :bill_address_id, name: 'index_spree_users_on_bill_address_id'
    end
    unless index_exists?(:spree_users, :ship_address_id)
      add_index :spree_users, :ship_address_id, name: 'index_spree_users_on_ship_address_id'
    end
    unless index_exists?(:spree_users, :reset_password_token)
      add_index :spree_users, :reset_password_token, unique: true, name: 'index_spree_users_on_reset_password_token'
    end
  end
end