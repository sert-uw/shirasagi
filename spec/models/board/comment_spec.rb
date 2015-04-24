require 'spec_helper'

RSpec.describe Board::Comment, type: :model, dbscope: :example do
  describe "validation" do
    it { expect(build(:board_comment)).to be_valid }
    it { expect(build(:board_comment, body: nil)).not_to be_valid }
  end

  describe "call topic.update_latest_commented! after save" do
    it do
      comment = create :board_comment
      expect_any_instance_of(Board::Topic)
        .to receive(:update_latest_commented!).once
      comment.save
    end
  end
end
