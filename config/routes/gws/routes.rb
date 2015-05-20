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
      resources :comments, only: [:index, :new, :create]
    end
    resources :comments, only: [:show, :edit, :destroy]
  end
end
