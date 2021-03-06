class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true

  scope :availables, -> { where(visible: true) }
  scope :recent, -> { order(created_at: :desc) }

  def status
    visible ? "⭕️" : "❌"
  end

  def default_values
    self.visible ||= false
    self.vote = 0
  end
end
