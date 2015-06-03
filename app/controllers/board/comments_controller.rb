class Board::CommentsController < ApplicationController
  include Gws::BaseFilter
  include SS::CrudFilter

  before_action :set_topic, only: [:create]
  before_action :comment_authority_check, only: [:edit, :destroy]

  model Board::Post

  def fix_params
    { user: @cur_user, group: @cur_group }
  end

  def get_params
    params.require(:comment).permit(permit_fields).merge(fix_params)
  end

  def set_item
    super
    @topic = @item.parent
  end

  def set_topic
    @topic = @model.find(params[:topic_id])
  end

  def create
    comment = @topic.children.build get_params
    render_create comment.save, render_options
  end

  def destroy
    render_destroy @item.destroy, render_options
  end

  private
    def render_options
      { location: board_topic_path(@cur_group.id, @topic.id) }
    end
end
