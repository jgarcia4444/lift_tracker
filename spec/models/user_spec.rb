require_relative "../spec_helper"

RSpec.describe User do

    before do 
        @user = User.create(username: "Test 1", password: "password")
    end

    after do
        User.destroy_all
    end

    it 'can slug the username' do
        expect(@user.slug).to eq("Test-1")
    end

    it 'can find a user based on the slug' do
        slug = @user.slug
        expect(User.find_by_slug(slug).username).to eq("Test 1")
    end

    it 'has a secure password' do
        expect(@user.authenticate("pass")).to eq(false)
        expect(@user.authenticate("password")).to eq(@user)
    end
    
end