# Comment class for BBS.
class Board::Comment
  include SS::Document

  field :body, type: String

  embedded_in :topic, inverse_of: :comments

  validates :body, presence: true

  after_save ->{ topic.update_latest_commented! }
end
