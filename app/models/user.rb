class User < ApplicationRecord

    has_secure_password
    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token
   
   #  has_many :jobs
    validates :name , presence: true, length: {maximum: 50}
    validates :email, presence:  true
    validates :phone, presence:  true
    validates :password, presence:  true
    validates :password_confirm, presence:  true

  

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}

    private

        def create_remember_token
            self.remember_token =SecureRandom.urlsafe_base64
        end
end
