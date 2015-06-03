class Board::TopicsController < ApplicationController
  include Gws::BaseFilter
  include SS::CrudFilter

  before_action :topic_authority_check, only: [:edit, :destroy]

  model Board::Post

  def fix_params
    { user: @cur_user, group: @cur_group }
  end

  def index
    @items = Board::Post.topic.order(descendants_updated: -1)
  end

  def show
    @comments = @item.children.order(descendants_updated: -1)
  end
end
