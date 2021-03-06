module Spree
  class User < Spree::Base
    include UserMethods

    devise :database_authenticatable, :registerable, :recoverable,
           :rememberable, :trackable, :encryptable
    devise :confirmable if Spree::Auth::Config[:confirmable]
    devise :validatable if Spree::Auth::Config[:validatable]
    devise :omniauthable if Spree::Auth::Config[:omniauthable]

    acts_as_paranoid
    after_destroy :scramble_email_and_password

    def password=(new_password)
      generate_spree_api_key if new_password.present? && spree_api_key.present?
      super
    end

    before_validation :set_login

    users_table_name = User.table_name
    roles_table_name = Role.table_name

    scope :admin, -> { includes(:spree_roles).where("#{roles_table_name}.name" => "admin") }

    def self.admin_created?
      User.admin.exists?
    end

    def admin?
      has_spree_role?('admin')
    end

    def confirmed?
      !!confirmed_at
    end

    protected

    def password_required?
      !persisted? || password.present? || password_confirmation.present?
    end

    private

    def set_login
      # for now force login to be same as email, eventually we will make this configurable, etc.
      self.login ||= email if email
    end

    def scramble_email_and_password
      self.email = SecureRandom.uuid + "@example.net"
      self.login = email
      self.password = SecureRandom.hex(8)
      self.password_confirmation = password
      save
    end
  end
end