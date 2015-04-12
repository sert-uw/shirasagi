require 'spec_helper'

RSpec.describe Board::Response, type: :model, dbscope: :example do
  describe "valid" do
    it "isn't valid without body" do
      response = Board::Response.new(body: 'body')
      expect(response).to be_valid
    end
  end

  describe "invalid" do
    it "without body" do
      response = Board::Response.new
      expect(response).not_to be_valid
    end
  end
end
