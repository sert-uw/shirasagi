# Topic class for BBS.
class Board::Topic
  include SS::Document

  field :title, type: String
  field :body, type: String
  field :latest_commented, type: DateTime

  embeds_many :comments, class_name: 'Board::Topic'

  validates :title, presence: true
  validates :body, presence: true

  scope :order_by_latest_commented, ->{ order_by :latest_commented.desc }

  after_create ->{ update_latest_commented! }

  def update_latest_commented!
    update latest_commented: Time.zone.now
  end
end
