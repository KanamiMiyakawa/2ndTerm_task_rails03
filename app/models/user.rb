class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }

  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  mount_uploader :image, ImageUploader

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :blogs
  has_many :favorites, dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source: :blog

  #user.active_relationshipsで、自分のidと同じfollower_idが記録されているレコードを取得
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  #user.followingにより、上のアソシエーションを通して、followedのアソシエーションから取得
  has_many :following, through: :active_relationships, source: :followed

  #user.passive_relationshipsで、自分のidと同じfollowed_idが記録されているレコードを取得
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  #user.followersで上のアソシエーションを通して、followerのアソシエーションから取得
  has_many :followers, through: :passive_relationships, source: :follower

  before_validation { email.downcase! }

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

end
