class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites,dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id',dependent: :destroy
  # has_many :followers, through: :passive_relationships, source: :follower
  # has_many :active_relationships, class_name: 'Relationship',foreign_key: 'follower_id',dependent: :destroy
  # has_many :following, through: :active_relationships, source: :followed
  # has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # has_many :follower_user, through: :followed, source: :follower
  # has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # has_many :following_user, through: :follower, source: :followed
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # def follow(other_user)
  #   active_relationships.create(followed_id: other_user.id)
  # end

  # def unfollow(other_user)
  #   active_relationships.find_by(followed_id: other_user.id).destroy
  # end

  # def following?(other_user)
  #   following.include?(other_user)
  # end


  def follow(user_id)
      relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
      followings.include?(user)
  end


end
