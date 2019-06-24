class RelationshipsController < ApplicationController

    before_action :signed_in_user

    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }



    def create
        @user = User.find(params[:relationship][:followed_id])
        current_user.follow!(@user)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end

    def destroy
        @user = Relationship.find(params[:id]).followed
        current_user.unfollow!(@user)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end

        before { sign_in user }

        describe "creating a relationship with Ajax" do

            it "should increment the Relationship count" do
                expect do
                    xhr :post, :create, relationship: { followed_id: other_user.id }
                end.should change(Relationship, :count).by(1)
            end

            it "should respond with success" do
                xhr :post, :create, relationship: { followed_id: other_user.id }
                response.should be_success
            end
        end
        describe "destroying a relationship with Ajax" do
            before { user.follow!(other_user) }
            
            let(:relationship) { user.relationships.find_by_followed_id(other_user) }
            it "should decrement the Relationship count" do
                expect do
                    xhr :delete, :destroy, id: relationship.id
                end.should change(Relationship, :count).by(-1)
            end
            it "should respond with success" do
                 xhr :delete, :destroy, id: relationship.id
                 response.should be_success
            end 
        end


        private

           def followed_params
            params.require(:relationship).permit(:followed_id)
           end
    
end
