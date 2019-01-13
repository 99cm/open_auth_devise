module OmniauthHelpers
  def set_omniauthable_option(value)
    Spree::Auth::Config[:omniauthable] = value
    Spree.send(:remove_const, 'User')
    load File.expand_path("../../../app/models/spree/user.rb", __FILE__)
  end
end

RSpec.configure do |c|
  c.include OmniauthHelpers
end