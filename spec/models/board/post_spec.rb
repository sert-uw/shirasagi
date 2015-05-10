require 'spec_helper'

RSpec.describe Board::Post, type: :model, dbscope: :example do
  describe "FactoryGirl test" do
    describe "board_post" do
      before { create :board_post }
      it { expect(described_class.count).to eq 1 }
    end

    describe "board_topic" do
      let!(:topic) { create :board_topic }
      it { expect(described_class.count).to eq 1 }
      it { expect(topic.parent).to be_nil }
    end

    describe "board_comment" do
      let!(:comment) { create :board_comment }
      it { expect(described_class.count).to eq 2 }

      describe "parent" do
        subject { comment.parent }
        it { is_expected.not_to be_nil }
        it { is_expected.to be_a_kind_of described_class }

        it "is a topic, so its parent is nil" do
          expect(comment.parent.parent).to be_nil
        end
      end
    end

    describe "board_comment_to_comment" do
      let!(:comment) { create :board_comment_to_comment }
      it { expect(described_class.count).to eq 3 }

      describe "parent" do
        subject { comment.parent }
        it { is_expected.not_to be_nil }
        it { is_expected.to be_a_kind_of described_class }

        it "is a comment, so its parent is NOT nil" do
          expect(comment.parent.parent).not_to be_nil
        end

        describe "parent" do
          it "is a topic, so its parent is nil" do
            expect(comment.parent.parent.parent).to be_nil
          end
        end
      end
    end
  end

  describe "dependent destroy" do
    context "topic > comment" do
      let!(:comment) { create :board_comment }
      subject { comment.parent.destroy }
      it { expect { subject }.to change { described_class.count }.by(-2) }
    end

    context "topic > comment > comment" do
      let!(:comment) { create :board_comment_to_comment }

      context "destroy parent" do
        subject { comment.parent.destroy }
        it { expect { subject }.to change { described_class.count }.by(-2) }
      end

      context "destroy parent of parent" do
        subject { comment.parent.parent.destroy }
        it { expect { subject }.to change { described_class.count }.by(-3) }
      end
    end
  end
end
