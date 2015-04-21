class Board::TopicsController < ApplicationController
  include SS::BaseFilter

  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Board::Topic.order_by_newer_response
  end

  def show
    @responses = @topic.responses
  end

  def new
    @topic = Board::Topic.new
  end

  def edit
  end

  def create
    @topic = Board::Topic.new(topic_params)
    if @topic.save
      redirect_to board_topics_url(id: @topic._id), notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to board_topics_url(id: @topic._id), notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to board_topics_url, notice: 'Topic was successfully destroyed.'
  end

  private
    def set_topic
      @topic = Board::Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :body)
    end
end
