class Board::Post
  include SS::Document

  field :body, type: String
  field :descendants_updated, type: DateTime

  belongs_to :parent, class_name: "Board::Post"

  has_many :children, class_name: "Board::Post", dependent: :destroy
end
