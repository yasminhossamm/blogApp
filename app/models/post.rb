class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :body, presence: true
  # validates :tags, length: { minimum: 1 }

  # Ensure that a post has at least one tag
  validate :must_have_at_least_one_tag

  private

  def must_have_at_least_one_tag
    errors.add(:tags, "must have at least one tag") if tags.empty?
  end
end
