class User < ApplicationRecord
    #dependent if we destroy our user it will also destroy all articles that user has been created
    has_many :articles, dependent: :destroy
    before_save { self.email = email.downcase }
    validates :username, presence:true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105}, uniqueness: { case_sensitive: false }, 
    #chek the validity of email format
    format: { with: VALID_EMAIL_REGEX }
    validates :password, presence:true, length: { minimum: 5, maximum: 50}
    has_secure_password


end 