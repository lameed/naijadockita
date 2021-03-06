class User < ActiveRecord::Base
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :feeds, dependent: :destroy
         has_many :posts, dependent: :destroy
         has_many :comments, dependent: :destroy
         
         has_attached_file :avatar, styles: { medium: "152x152#" }
         validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
