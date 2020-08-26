class Article < ApplicationRecord
  ## validations
  validates :title, :body, presence: true

  ## scopes
  default_scope { order(created_at: :desc) }

  ## associations
  belongs_to :user
  has_many :comments, dependent: :destroy  ## delete related comments on article delete
end
