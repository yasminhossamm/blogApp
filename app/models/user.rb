class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    normalizes :email, with: ->(email) {email.strip.downcase}

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
end
