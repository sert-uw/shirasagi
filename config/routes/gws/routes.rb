SS::Application.routes.draw do
  # WIP
  #gws "schedule" do
  #  resources :plans
  #end

  # WIP
  #gws "reservation" do
  #  resources :plans
  #end

  gws "board" do
    resources :topics do
      resource :responses
    end
  end
end
