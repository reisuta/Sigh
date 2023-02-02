require 'rails_helper'

RSpec.describe 'Aims', type: :request do

  describe 'GET /aims' do
    let!(:aim) { create(:aim) }
    it '正しいステータスコードが返ってくる' do
      get '/aims'
      expect(response).to have_http_status(:success)
    end

    it '正しいステータスコードが返ってくる' do
      get "/aims/#{aim.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
