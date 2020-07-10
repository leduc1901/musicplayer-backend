class User < ApplicationRecord
    has_many :playlists
    has_one_attached :avatar
    has_secure_password #bat buoc can thiet de dang nhap 
    before_save {self.email = email.downcase}
    before_create :default_values

    # validates :password, presence: true , length: {minimum:5, maximum:50}. on: :create
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence:true , length:{minimum:6 ,maximum:255},format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive:false}
    validates :name, presence:true , length:{minimum:5 , maximum:50}, uniqueness:true   
    validates :password , presence:true, length: {minimum:5, maximum:50}, on: :create

    def default_values
        self.downloads ||= 0 # note self.status = 'P' if self.status.nil? might be safer (per @frontendbeauty)
    end
end
