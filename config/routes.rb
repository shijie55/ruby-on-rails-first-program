Rails.application.routes.draw do
  devise_for :companies
  resources :people
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 嵌套路由
  resources :events do
  	resources :attendees, :controller => "event_attendees"

  	collection do
  		get "latest"

      post "bulk_update"
  	end
  end
  # 給一個命名空間，防止命名衝突
  namespace :admin do
    resources :events
  end


  root :to => "welcome#index"
end
