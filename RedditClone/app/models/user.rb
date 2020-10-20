class User < ApplicationRecord 
    validates :username, :password_digest, presence: true 
    validates :password, length: { minimum: 6, allow_nil: true }

    has_many :subs, 
        primary_key: :id, 
        foreign_key: :user_id, 
        class_name: :Sub 

    has_many :posts, 
    primary_key: :id, 
    foreign_key: :author_id, 
    class_name: :Post

















    attr_reader :password 
    after_initialize :ensure_session_token
    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token 
        self.session_token ||= SecureRandom.base64
    end

    def reset_session_token! 
        self.session_token = SecureRandom.base64
        self.save! 
        self.session_token
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return user if user && user.is_password?(password)
        # return nil if user.nil? 
        # if user.is_password?(password)
        #     return user 
        # end 
        # return nil 
    end 
end