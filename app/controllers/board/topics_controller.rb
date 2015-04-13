class Board::TopicsController < ApplicationController
  def index
    @topics = Board::Topic.order_by_newer_response
  end
end
