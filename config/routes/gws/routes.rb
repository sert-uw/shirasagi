SS::Application.routes.draw do
  gws "schedule" do
    resources :plans
  end

  # WIP
  #gws "reservation" do
  #  resources :plans
  #end

  gws "board" do
    resources :topics do
      resources :comments
    end
  end
end
