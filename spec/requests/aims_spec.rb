require 'rails_helper'

RSpec.describe 'Aims', type: :request do
  let!(:aim1) { create(:aim) }
  let(:aim_params) { { title: 'aim1', reason: 'test', advantage: 'test2' } }

  describe 'GET /aims' do
    it '正しいステータスコードが返ってくる' do
      get '/aims'
      expect(response).to have_http_status(:success)
    end

    it '正しいステータスコードが返ってくる' do
      get "/aims/#{aim1.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get "/aims/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/aims/#{aim1.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'returns http success' do
      post "/aims", params: { aim: aim_params }
      expect(response).to have_http_status(302)
    end

    context '正常系' do
      it 'レコードの数が一つ増える' do
        expect do
          post "/aims", params: { aim: aim_params }
        end.to change { Aim.count }.by(1)
      end

      it '一覧画面にリダイレクトされる' do
        post "/aims", params: { aim: aim_params }
        expect(response).to redirect_to(aims_path)
      end
    end

    context '異常系' do
      before do
        aim_params[:title] = ''
      end

      it 'レコードの数が増えない' do
        expect do
          post "/aims", params: { aim: aim_params }
        end.to change { Aim.count }.by(0)
      end

      it '新規作成画面にレンダリングされる' do
        post "/aims", params: { aim: aim_params }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH /update' do
    it 'returns http success' do
      patch "/aims/#{aim1.id}", params: { aim: aim_params }
      expect(response).to have_http_status(302)
    end

    context '正常系' do
      it 'レコードの値が変更されている' do
        patch "/aims/#{aim1.id}", params: { aim: aim_params }
        expect(aim1.reload[:title]).to eq 'aim1'
      end

      it '一覧画面にリダイレクトされる' do
        patch "/aims/#{aim1.id}", params: { aim: aim_params }
        expect(response).to redirect_to(aim_path(aim1.id))
      end
    end

    context '異常系' do
      before do
        aim_params[:title] = ''
      end

      it 'レコードの値が変更されていない' do
        patch "/aims/#{aim1.id}", params: { aim: aim_params }
        expect(aim1.reload[:title]).to eq '目標1'
      end

      it '新規作成画面にレンダリングされる' do
        patch "/aims/#{aim1.id}", params: { aim: aim_params }
        expect(response).to render_template :edit
      end
    end
  end


  describe 'DELETE /destroy' do
    it 'レコードの値が減ること' do
      expect do
        delete "/aims/#{aim1.id}"
      end.to change { Aim.count }.by(-1)
    end

    it '一覧画面にリダイレクトされる' do
      delete "/aims/#{aim1.id}"
      expect(response).to redirect_to(aims_path)
    end
  end
end
