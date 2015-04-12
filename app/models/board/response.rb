# Response class for BBS.
#
# This class belongs to a *Board::Thread* class.
class Board::Response
  include SS::Document

  field :body, type: String

  belongs_to :thread, class_name: 'Board::Thread'

  validates :body, presence: true
end
