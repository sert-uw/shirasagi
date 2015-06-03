class Board::Post
  include SS::Document

  field :name, type: String
  field :text, type: String
  field :descendants_updated, type: DateTime

  permit_params :name, :text

  belongs_to :group, class_name: "SS::Group"
  belongs_to :user, class_name: "SS::User"
  belongs_to :parent, class_name: "Board::Post"

  has_many :children, class_name: "Board::Post", dependent: :destroy

  before_save :set_descendants_updated
  after_save :update_parent_descendants_updated

  def set_descendants_updated
    self.descendants_updated = updated
  end

  def update_parent_descendants_updated(time = nil)
    if parent.present?
      time ||= descendants_updated
      parent.set descendants_updated: time
      parent.update_parent_descendants_updated time
    end
  end

  scope :topic, ->{ exists parent_id: false }
  scope :comment, ->{ exists parent_id: true }
end
