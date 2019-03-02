require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET#new" do 
        it 'renders the user creation page' do 
            get :new 
            expect(response).to render_template(:new)
        end
    end
    describe "POST#create" do 
        before :each do 
            create(:user)
            allow(subject).to receive(:user).and_return(User.last)
        end
        let!(:valid_user) { { user: {name: 'man', password: 'startrek'} }}
        let!(:invalid_user) { { user: {name: 'man', password: 'dd'} }}
        context "valid user credentials" do 
            it "creates a new user" do 
                post :create, params: valid_user
                expect(User.last).to eq('man')
            end
            it "redirects to goals#index" do
                expect(response).to redirect_to(goals_url)
            end
        end 

        context "invalid user credentials" do 
            it "should not creates a new user" do 
                post :create, params: invalid_user
                expect(User.last).to_not eq('man')
            end

            it "renders users#new" do 
                expect(response).to have_http_status(422)
                expect(response).to render_template(:new)
            end
            it 'adds errors to flash' do 
                expect(flash[:errors]).to_be present
            end
        end
        
    end


end
