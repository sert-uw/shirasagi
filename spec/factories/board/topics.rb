FactoryGirl.define do
  factory :board_topic, class: Board::Topic do
    title 'title'
    body 'body'
  end
end
