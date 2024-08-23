# frozen_string_literal: true

require 'rails_helper'

describe RoomsController do
  context 'POST create' do
    let!(:user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'success' do
      subject do
        post :create, params: {
          room: {
            name: 'Testing',
            description: 'A place to discuss testing!'
          }
        }
      end

      it 'creates and redirects to room' do
        subject

        user.reload
        room = Room.last

        expect(room.name).to eq('Testing')
        expect(room.description).to eq('A place to discuss testing!')
        expect(user.rooms.last).to eq(room)

        expect(response.status).to eq(302)
        expect(response).to redirect_to("/rooms/#{room.id}")
        expect(flash[:notice]).to be_present
      end
    end

    context 'failure' do
      subject do
        post :create, params: {
          room: {
            name: 'Testing',
            description: 'A place to discuss testing!'
          }
        }
      end

      before do
        allow_any_instance_of(Room).to receive(:save).and_return(false)
      end

      it 'does not create room and redirects to room creation' do
        subject

        user.reload

        expect(Room.count).to eq(0)
        expect(user.rooms.count).to eq(0)

        expect(response.status).to eq(302)
        expect(response).to redirect_to('/rooms/new')
        expect(flash[:alert]).to be_present
      end
    end
  end

  context 'GET show' do
    let!(:user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'failure' do
      subject do
        get :show, params: { id: 1 }
      end

      it 'renders new' do
        expect(controller).to receive(:render).with(:new)
        subject
      end
    end
  end
end
