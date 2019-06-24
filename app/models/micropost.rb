class Micropost < ApplicationRecord

    belongs_to :user

    validates :content, presence: true, length: {maximum: 140}
    validates :user_id, presence: true
    default_scope{order(created_at: :desc) }


    def self.from_users_followed_by(user)
        followed_id ="SELECT followed_id FROM relationships
        WHERE follower_id = :user_id"
        where("user_id IN (#{followed_id}) OR user_id = :user_id",user_id: user.id)
    end

end
