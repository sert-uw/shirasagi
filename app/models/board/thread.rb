class Board::Thread
  include SS::Document

  field :title, type: String
  field :body, type: String

  has_many :responses, class_name: 'Board::Response', dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
