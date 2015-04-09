class Board::CommentsController < ApplicationController
  include Gws::BaseFilter

  before_action :set_topic
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @topic.children.order(created: -1)
  end

  def show
  end

  def new
    @comment = @topic.children.build
  end

  def create
    @comment = @topic.children.build(comment_params)
    if @comment.save
      redirect_to "/..g#{current_group.id}/board/topics/#{@topic.id}", notice: 'Response was successfully created.'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to "/..g#{current_group.id}/board/topics/#{@topic.id}", notice: 'Response was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to "/..g#{current_group.id}/board/topics/#{@topic.id}", notice: 'Response was successfully destroyed.'
  end

  private
    def set_topic
      @topic = Board::Post.find(params[:topic_id])
    end

    def set_comment
      @comment = @topic.children.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
