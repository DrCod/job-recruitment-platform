class Micropost < ApplicationRecord

    belongs_to :user

    validates :content, presence: true, length: {maximum: 140}
    validates :user_id, presence: true
    default_scope{order(created_at: :desc) }


    def self.from_users_followed_by(user)
        followed_users_id ="SELECT followed id FROM relationships
        WHERE follower id = :user id"
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",user_id: user.id)
    end

end
