FactoryGirl.define do
  factory :board_comment, class: Board::Comment do
    association :topic, factory: :board_topic
    body 'body'
  end
end
