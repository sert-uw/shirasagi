require 'spec_helper'

RSpec.describe Board::Thread, type: :model, dbscope: :example do
  it "isn't valid without title and body" do
    thread = Board::Thread.new
    thread.title = "title"
    thread.body = "body"
    expect(thread).to be_valid
  end

  it "isn't valid without title" do
    thread = Board::Thread.new
    thread.title = nil
    thread.body = "body"
    expect(thread).not_to be_valid
  end

  describe "responses" do
    let(:thread) {Board::Thread.new title: 'title', body: 'body'}

    it "has 1 response" do 
      thread.responses Board::Response.new body: 'message'
      expect(thread).to be_valid
    end

    it "has many response" do
      10.times do
        thread.responses Board::Response.new body: 'message'
      end

      expect(thread).to be_valid
    end
  end
end
