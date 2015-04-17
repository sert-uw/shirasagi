# Thread class for BBS.
class Board::Thread
  include SS::Document

  field :title, type: String
  field :body, type: String

  has_many :responses, class_name: 'Board::Response', dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  # The latest datetime of thread or response created.
  #
  # @return [DateTime]
  #   When a response exists, the latest response's *created*.
  #   When there is no response, *created* of this thread.
  def latest_created_datetime
    response = responses.order_by('created DESC').limit(1)
    response.empty? ? created : response.first.created
  end

  class << self
    # Get all threads ordered by *latest_created_datetime*.
    #
    # @return [Array<Board::Thread>]
    #   All threads ordered by *latest_created_datetime*.
    def order_by_newer_response
      # TODO Modify to *scope* for usability.
      all.sort_by(&:latest_created_datetime).reverse
    end
  end
end
