class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :username,
            presence: true,
            uniqueness: true,
            length: {
              minimum: 5,
              maximum: 50
            }

  validates :email, presence: true, uniqueness: true

  has_many :posts
  has_many :comments

  has_many :active_relationships,
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :passive_relationships,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Post
      .where(
        "user_id IN (:following_ids) OR user_id = :user_id",
        following_ids: following_ids,
        user_id: id
      )
      .availables
      .recent
  end
end
