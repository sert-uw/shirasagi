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
end
