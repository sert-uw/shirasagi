class Board::Thread
  include Mongoid::Document

  field :title, type: String
  field :body, type: String

  validates :title, presence: true
  validates :body, presence: true
end
