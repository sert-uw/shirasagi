require 'spec_helper'

RSpec.describe Board::Topic, type: :model, dbscope: :example do
  describe "validation" do
    it { expect(build(:board_topic)).to be_valid }
    it { expect(build(:board_topic, body: nil)).not_to be_valid }
    it { expect(build(:board_topic, title: nil)).not_to be_valid }
    it { expect(build(:board_topic, title: nil, body: nil)).not_to be_valid }
  end

  describe "order_by_latest_commented scope" do
    subject { described_class.order_by_latest_commented }

    context "no topic" do
      it { is_expected.to be_empty }
    end

    context "1 topic" do
      let!(:topics) { create_list :board_topic, 1 }
      it { is_expected.to eq topics }
    end

    context "2 topics" do
      before do
        @t1 = create :board_topic
        @t2 = create :board_topic
      end

      let!(:topics) { [@t2, @t1] }

      it { is_expected.to eq topics }
    end
  end

  describe "#update_latest_commented!" do
    before { @topic_id = create(:board_topic).id }

    let(:topic) { described_class.find @topic_id }

    it do
      expect { topic.update_latest_commented! }
        .to change { topic.latest_commented }
    end
  end
end
