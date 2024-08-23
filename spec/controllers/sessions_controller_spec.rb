# frozen_string_literal: true

require 'rails_helper'

describe SessionsController do
  context 'POST create' do
    context 'success' do
      let!(:user) { create(:user) }
      subject do
        post :create, params: {
          email: user.email,
          password: user.password
        }
      end

      it 'sets session and redirects to root' do
        subject

        expect(response.status).to eq(302)
        expect(response).to redirect_to('/')
        expect(session[:user_id]).to eq(user.id)
        expect(flash[:notice]).to be_present
      end
    end

    context 'failure' do
      let!(:user) { create(:user) }
      subject do
        post :create, params: {
          email: user.email,
          password: 'password'
        }
      end

      before do
        allow_any_instance_of(User).to receive(:authenticate).and_return(false)
      end

      it 'does not set session and redirects to login' do
        subject

        expect(response.status).to eq(302)
        expect(response).to redirect_to('/login')
        expect(session[:user_id]).not_to be_present
        expect(flash[:alert]).to be_present
      end
    end
  end

  context 'POST destroy' do
    subject do
      post :destroy
    end

    before do
      session[:user_id] = 1
    end

    it 'clears the session and redirects to root' do
      subject

      expect(response.status).to eq(302)
      expect(response).to redirect_to('/')
      expect(session[:user_id]).not_to be_present
      expect(flash[:notice]).to be_present
    end
  end
end
