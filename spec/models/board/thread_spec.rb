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

  describe "#latest_created_datetime" do
    subject { thread.latest_created_datetime }

    before do
      @thread_id = Board::Thread.create(title: 'title', body: 'body').id
    end

    let(:thread) { Board::Thread.find(@thread_id) }

    context "when no response" do
      it { is_expected.to eq thread.created }
    end

    let(:response) { Board::Response.find(@res_id) }

    context "when one response" do
      before do
        @res_id = thread.responses.create(body: 'body').id
      end

      it { is_expected.to eq response.created }
    end

    context "when two responses" do
      before do
        thread.responses.create(body: 'body').id
        @res_id = thread.responses.create(body: 'body').id
      end

      it { is_expected.to eq response.created }
    end
  end

  describe ".order_by_newer_response" do
    let(:threads) { Board::Thread.order_by_newer_response }

    context "no thread" do
      it { expect(threads).to be_empty }
    end

    context "thread exist" do
      context "one thread" do
        before do
          @thread = Board::Thread.create(title: 't', body: 'b')
        end

        it { expect(threads.first.id).to eq @thread.id }
      end

      context "two thread" do
        context "no response" do
          before do
            @thread1 = Board::Thread.create(title: 't1', body: 'b1')
            @thread2 = Board::Thread.create(title: 't2', body: 'b2')
          end

          it { expect(threads[0].id).to eq @thread2.id }
          it { expect(threads[1].id).to eq @thread1.id }
        end

        context "thread1 has response" do
          before do
            @thread1 = Board::Thread.create(title: 't1', body: 'b1')
            @thread2 = Board::Thread.create(title: 't2', body: 'b2')

            @thread1.responses.create body: 'body'
          end

          it { expect(threads[0].id).to eq @thread1.id }
          it { expect(threads[1].id).to eq @thread2.id }
        end

        context "two thread has response" do
          before do
            @thread1 = Board::Thread.create(title: 't1', body: 'b1')
            @thread2 = Board::Thread.create(title: 't2', body: 'b2')

            @thread1.responses.create body: 'body'
            @thread2.responses.create body: 'body'
          end

          it { expect(threads[0].id).to eq @thread2.id }
          it { expect(threads[1].id).to eq @thread1.id }
        end
      end
    end
  end
end
