class Board::Thread
  include SS::Document

  field :title, type: String
  field :body, type: String

  validates :title, presence: true
  validates :body, presence: true
end
