class Board::TopicsController < ApplicationController
  include Gws::BaseFilter

  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Board::Post.topic.order(descendants_updated: -1)
  end

  def show
    @comments = @topic.children
  end

  def new
    @topic = Board::Post.new
  end

  def create
    @topic = Board::Post.new(topic_params)
    @topic.user = @cur_user
    if @topic.save
      redirect_to board_topic_url(id: @topic.id), notice: t('board.topic.notice.create')
    else
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to board_topics_url(id: @topic._id), notice: t('board.topic.notice.update')
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to board_topics_url, notice: t('board.topic.notice.delete')
  end

  private
    def set_topic
      @topic = Board::Post.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :body)
    end
end
