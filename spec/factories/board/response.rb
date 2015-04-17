FactoryGirl.define do
  factory :board_response, class: Board::Response do
    association :thread, factory: :board_thread
    body "body"
  end
end
