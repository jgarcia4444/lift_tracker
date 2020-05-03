require_relative "../spec_helper"

RSpec.describe "LiftType" do
    before do
        lift_type_array = ["Bench", "Squat", "Deadlift"]
        lift_type_array.each do |name|
            LiftType.create(:name => name)
        end
    end
    after do
        LiftType.destroy_all
    end

    context "has a name value" do
        it 'returns a name value' do
            lift_type_1 = LiftType.find(1)
            expect(lift_type_1.name).to eq("Bench")
        end
    end

    context "has an id" do
        it 'has an id, due to being saved' do
            expect(LiftType.find(1)).to be_truthy
        end
    end

end