class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def own?(object)
    id == object.user_id
  end

  def like(post)
    likes.find_or_create_by(post: post)
  end

  def like?(post)
    like_posts.include?(post)
  end

  def unlike(post)
    like_posts.delete(post)
  end
end
