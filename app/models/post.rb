class Post < ApplicationRecord

has_many :comments, dependent: :destroy
belongs_to :user
belongs_to :genre
attachment :image
has_many :likes, dependent: :destroy

def self.search(keyword)
  where(["name like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
end

def liked_by?(user)
    likes.where(user_id: user.id).exists?
end

end
