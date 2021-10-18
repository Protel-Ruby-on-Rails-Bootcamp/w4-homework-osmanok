class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true

  scope :availables, -> {where(visible: true)}
  scope :recent, -> {order(created_at: :desc)}

  def status
    if visible
      'Public'
    else
      'Private'
    end
  end
end
