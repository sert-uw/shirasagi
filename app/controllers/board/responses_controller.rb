class Board::ResponsesController < ApplicationController
  include SS::BaseFilter

  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :set_responses, only: [:new, :create]

  def index
    @responses = Board::Topic.find(params[:topic_id]).responses.order_by('created DESC')
  end

  def show
  end

  def new
    @response = @responses.build(response_params)
  end

  def create
    @response = @responses.build(response_params)
    if @response.save
     redirect_to "/..g:group/board/topics/" + params[:topic_id], notice: 'Response was successfully created.'
    else
      render :new
    end
  end

  def update
    if @response.update(response_params)
     redirect_to "/..g:group/board/topics/" + params[:topic_id], notice: 'Response was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @response.destroy
     redirect_to "/..g:group/board/topics/" + params[:topic_id], notice: 'Response was successfully destroyed.'
  end

  private
    def set_response
      @response = Board::Topic.find(params[:topic_id]).responses.find(params[:id])
    end

    def set_responses
      @responses = Board::Topic.find(params[:topic_id]).responses
    end

    def response_params
      params.require(:response).permit(:body)
    end
end
