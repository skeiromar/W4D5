require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of (:name) } 
  it { should validate_presence_of (:password_digest)}
  it { should validate_presence_of (:session_token)}
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'uniqueness' do 
    before :each do 
       create(:user)
    end

    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'User::find_by_credentials' do
    let!(:user) { create(:user) }
    context 'with valid credentials' do
      it "should return user instance" do
        expect(User.find_by_credentials(user.name, user.password)).to eq(user)
      end
    end
    context 'with invalid credentials' do
      it "should return nil" do
        expect(User.find_by_credentials(user.name, 'startrek')).to eq(nil)
      end
    end
  end
end

