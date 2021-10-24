class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :recent, -> { order(created_at: :desc) }
  scope :approved_commments?, -> { where(approved: true) }
  scope :non_approved?, -> { where(approved: false) }
  
  def default_values
    self.approved = false
  end

end
