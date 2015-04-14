class Board::ResponsesController < ApplicationController
  def index
    @responses = Board::Response.where(thread_id: :thread_id)
  end

  def delete
    response = Board::Response.find(params[:id])
    response.destroy
  end
end
