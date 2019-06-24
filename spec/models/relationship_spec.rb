require 'spec_helper'

RSpec.describe Relationship, type: :model do
  
  let(:follower){ FactoryBot.create(:user) }
  let(:followed) {FactoryBot.create(:user) }
  let(:relationship){ follower.relationships.build(followed_id: followed.id)}

  subject {relationship}

  it{should be_valid}

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        Relationship.new(followed_id: followed_id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it{ should respond_to(:follower)}
    it{should respond_to(:followed)}
    its(:follower){ should == follower}
    its(:followed){should ==followed }
  end

  describe "when followed id is not present" do
    before {relationship.followed_id = nil}
    it{ should_not be_valid}
  end

  describe "when follower id is not present" do
    before{relationship.follower_id =nil}
    it{ should_not be_valid}
  end
end
