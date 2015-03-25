SS::Application.routes.draw do
  namespace :gws, path: '..g:group/gws' do
    resources :roles do
      get :delete, on: :member
    end
  end

  gws "schedule" do
    resources :plans do
      get :delete, on: :member
    end
    get "calendar" => "calendar#index"
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

  gws "share" do
    resources :files do
      get :view, on: :member
      get :thumb, on: :member
      get :download, on: :member
      get :delete, on: :member
    end
  end
end
