class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    unless data_source_exists?("spree_users")
      create_table :spree_users, force: true do |t|
        t.string :encrypted_password, limit: 128
        t.string :password_salt, limit: 128
        t.string :email
        t.string :remember_token
        t.datetime :remember_created_at
        t.string :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.string :persistence_token
        t.string :reset_password_token
        t.datetime :reset_password_sent_at
        t.string :perishable_token
        t.integer :sign_in_count, default: 0, null: false
        t.integer :failed_attempts, default: 0, null: false
        t.datetime :last_request_at
        t.datetime :current_sign_in_at
        t.datetime :last_sign_in_at
        t.string :current_sign_in_ip
        t.string :last_sign_in_ip
        t.string :login
        t.string :authentication_token
        t.string :unlock_token
        t.datetime :locked_at
        t.integer :ship_address_id
        t.integer :bill_address_id
        t.datetime :created_at, null: false
        t.datetime :updated_at, null: false
        t.datetime :deleted_at
      end
    end
    
    add_index :spree_users, :bill_address_id, name: 'index_spree_users_on_bill_address_id'
    add_index :spree_users, :ship_address_id, name: 'index_spree_users_on_ship_address_id'
    add_index :spree_users, :email, name: 'index_spree_users_on_email', unique: true
    add_index :spree_users, :reset_password_token, unique: true, name: 'index_spree_users_on_reset_password_token'
    add_index :spree_users, :deleted_at, name: 'index_spree_users_on_deleted_at'
  end
end