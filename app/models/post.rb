class Post < ApplicationRecord

  acts_as_taggable_on :tags
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  validates :body, presence: true

end