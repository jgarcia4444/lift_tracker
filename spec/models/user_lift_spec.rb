require_relative "../spec_helper"

RSpec.describe "UserLift" do
    before do
        User.destroy_all
        LiftType.destroy_all
        UserLift.destroy_all
        User.create(username: "testuser1", password: "password")
        User.create(username: "testuser2", password: "password")
        lift_type_array = ["Bench", "Squat", "Deadlift"]
        lift_type_array.each do |name|
            LiftType.create(:name => name)
        end
        user1 = User.find_by(username: "testuser1")
        bench = LiftType.find_by(name: "Bench")
        UserLift.create(weight: "300", user_id: user1.id, lift_type_id: bench.id)
        user2 = User.find_by(username: "testuser2")
        squat = LiftType.find_by(name: "Squat")
        UserLift.create(weight: "360", user_id: user2.id, lift_type_id: squat.id)
    end
    after do
        User.destroy_all
        LiftType.destroy_all
        UserLift.destroy_all
    end

    context 'UserLifts have a User, LiftType and weight.' do
        it 'has a user' do
            user_lift_1 = User.find_by(username: "testuser1").user_lifts.first
            expect(user_lift_1.user).to be_truthy
        end

        it 'has a lift type' do
            user_lift_1 = User.find_by(username: "testuser1").user_lifts.first
            expect(user_lift_1.lift_type).to be_truthy
        end

        it 'has a weight' do
            user_lift_1 = User.find_by(username: "testuser1").user_lifts.first
            expect(user_lift_1.weight).to be_truthy
        end

    end

end