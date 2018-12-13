RSpec.describe Spree::ProductsController, type: :controller do
  let!(:product) { create(:product, available_on: 1.year.from_now) }
  let!(:user) { build_stubbed(:user, spree_api_key: 'fake') }

  subject(:request) { spree_get :show, id: product.to_param }

  before do
    allow(controller).to receive(:before_save_new_order)
    allow(controller).to receive(:spree_current_user) { user }
  end

  it 'allows admins to view non-active products' do
    allow(user).to receive(:has_spree_role?) { true }

    request
    expect(response.status).to eq(200)
  end

  it 'cannot view non-active products' do
    allow(user).to receive(:has_spree_role?) { false }

    request
    expect(response.status).to eq(404)
  end
end
