require 'spec_helper'

RSpec.describe Board::Thread, type: :model, dbscope: :example do
  it "isn't valid without title and body" do
    thread = build(:board_thread)
    expect(thread).to be_valid
  end

  it "isn't valid without title" do
    thread = build(:board_thread, title: nil)
    expect(thread).not_to be_valid
  end

  describe "#latest_created_datetime" do
    subject { thread.latest_created_datetime }

    before do
      @thread_id = create(:board_thread).id
    end

    let(:thread) { Board::Thread.find(@thread_id) }

    context "when no response" do
      it { is_expected.to eq thread.created }
    end

    let(:response) { Board::Response.find(@res_id) }

    context "when one response" do
      before do
        @res_id = create(:board_response, thread: thread).id
      end

      it { is_expected.to eq response.created }
    end

    context "when two responses" do
      before do
        thread.responses.create(body: 'body').id
        @res_id = create(:board_response, thread: thread).id
      end

      it { is_expected.to eq response.created }
    end
  end

  describe ".order_by_newer_response" do
    subject { Board::Thread.order_by_newer_response }

    context "no thread" do
      it { is_expected.to be_empty }
    end

    context "thread exist" do
      context "one thread" do
        before do
          @thread = create(:board_thread)
        end

        it { is_expected.to eq [@thread] }
      end

      context "two thread" do
        before do
          @thread1 = create(:board_thread)
          @thread2 = create(:board_thread)
        end

        context "no response" do
          it { is_expected.to eq [@thread2, @thread1] }
        end

        context "thread1 has a response" do
          before do
            create(:board_response, thread: @thread1)
          end

          it { is_expected.to eq [@thread1, @thread2] }
        end

        context "two threads have a response" do
          before do
            create(:board_response, thread: @thread1)
            create(:board_response, thread: @thread2)
          end

          it { is_expected.to eq [@thread2, @thread1] }
        end
      end
    end
  end
end
