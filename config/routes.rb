Blog::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'users/registration' => 'users#registration'
  get 'users/index' => 'users#index'
  get 'users/show(/:id)' => 'users#show'

  get 'forum/categories' => 'forum#categories'
  get 'forum/category_new' => 'forum#category_new'
  post 'forum/category_destroy(/:id)' => 'forum#category_destroy'
  post 'forum/category_create' => 'forum#category_create'

  get 'forum/ticket_list(/:id)' => 'forum#ticket_list'
  get 'forum/ticket(/:id)' => 'forum#ticket'
  get 'forum/ticket_new(/:id)' => 'forum#ticket_new'
  post 'forum/ticket_destroy(/:id)' => 'forum#ticket_destroy'
  post 'forum/ticket_create(/:id)' => 'forum#ticket_create'
  post 'forum/comment_create(/:id)' => 'forum#comment_create'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :users
  resources :forum

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
