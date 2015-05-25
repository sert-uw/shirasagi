class Board::CommentsController < ApplicationController
  include Gws::BaseFilter

  before_action :set_topic, only: [:index, :new, :update, :create]
  before_action :set_comment, only: [:show, :edit, :destroy]

  def index
    @comments = @topic.children.order(created: -1)
  end

  def show
  end

  def edit
    if @comment.user == @cur_user
      render :edit
    else
      redirect_to board_topic_path(current_group.id, @comment.parent.id), notice: t('board.no_authority')
    end
  end

  def new
    @comment = @topic.children.build
  end

  def create
    @comment = @topic.children.build(comment_params)
    @comment.user = @cur_user
    if @comment.save
      redirect_to board_topic_path(current_group.id, @topic.id), notice: t('board.comment.notice.create')
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to board_topic_path(current_group.id, @topic.id), notice: t('board.comment.notice.update')
    else
      render :edit
    end
  end

  def destroy
    if @comment.user == @cur_user
      @comment.destroy
      redirect_to board_topic_path(current_group.id, @comment.parent.id), notice: t('board.comment.notice.delete')
    else
      redirect_to board_topic_path(current_group.id, @comment.parent.id), notice: t('board.no_authority')
    end
  end

  private
    def set_topic
      @topic = Board::Post.find(params[:topic_id])
    end

    def set_comment
      @comment = Board::Post.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
