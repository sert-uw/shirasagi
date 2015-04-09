require 'spec_helper'

RSpec.describe Board::Thread, type: :model, dbscope: :example do
  describe "valid" do
    let(:thread) { Board::Thread.new body: 'body', title: 'title' }

    it "isn't valid without title and body" do
      expect(thread).to be_valid
    end
  end

  describe "invalid" do
    context "without body" do
      let(:thread) { Board::Thread.new title: 'title' }
      it { expect(thread).not_to be_valid }
    end

    context "without title" do
      let(:thread) { Board::Thread.new body: 'body' }
      it { expect(thread).not_to be_valid }
    end
  end
end
