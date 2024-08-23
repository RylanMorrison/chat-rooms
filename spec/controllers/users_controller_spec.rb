# frozen_string_literal: true

require 'rails_helper'

describe UsersController do
  context 'POST create' do
    context 'success' do
      subject do
        post :create, params: {
          user: {
            name: 'Test',
            email: 'test@email.com',
            password: 'password'
          }
        }
      end

      it 'creates user and redirects to profile' do
        subject

        user = User.last
        expect(user.name).to eq('Test')
        expect(user.email).to eq('test@email.com')

        expect(response.status).to eq(302)
        expect(response).to redirect_to("/users/#{user.id}")
        expect(flash[:notice]).to be_present
      end
    end

    context 'failure' do
      subject do
        post :create, params: {
          user: {
            name: 'Test',
            email: 'test@email',
            password: 'password'
          }
        }
      end

      before do
        allow_any_instance_of(User).to receive(:save).and_return(false)
      end

      it 'does not create user and redirects to signup' do
        subject

        expect(User.count).to eq(0)
        expect(response.status).to eq(302)
        expect(response).to redirect_to('/signup')
        expect(flash[:alert]).to be_present
      end
    end
  end

  context 'PATCH update' do
    context 'success' do
      let!(:user) { create(:user) }
      subject do
        patch :update, params: {
          id: user.id,
          user: {
            name: 'Test',
            email: 'test@email.com',
            password: 'newpass',
            password_confirmation: 'newpass'
          }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'updates user and redirects to edit' do
        subject

        user.reload
        expect(user.name).to eq('Test')
        expect(user.email).to eq('test@email.com')
        expect(user.password).to eq('newpass')

        expect(response.status).to eq(302)
        expect(response).to redirect_to("/users/#{user.id}/edit")
        expect(flash[:notice]).to be_present
      end
    end

    context 'failure' do
      let!(:user) { create(:user) }
      subject do
        patch :update, params: {
          id: user.id,
          user: {
            name: 'Test',
            email: 'test@email.com',
            password: 'newpass',
            password_confirmation: 'newpass'
          }
        }
      end

      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow_any_instance_of(User).to receive(:update).and_return(false)
      end

      it 'does not update user and redirects to edit' do
        subject

        user.reload
        expect(user.name).not_to eq('Test')
        expect(user.email).not_to eq('test@email.com')
        expect(user.password).not_to eq('newpass')

        expect(response.status).to eq(302)
        expect(response).to redirect_to("/users/#{user.id}/edit")
        expect(flash[:alert]).to be_present
      end
    end
  end
end
