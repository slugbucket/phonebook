Phonebook::Application.routes.draw do
  resources :client_policies

  resources :persist_chat_policies

  resources :mobility_policies

  resources :location_policies

  resources :archiving_policies

  resources :external_access_policies

  resources :pin_policies

  resources :client_version_policies

  resources :conference_policies

  resources :voice_policies

  resources :dial_plan_policies

  resources :policy_types
  
  resources :rooms

  resources :dialling_rights

  devise_for :users, controllers: {sessions: "sessions"}, :path_names => { :sign_in => "login", :sign_out => "logout" }
  
  resources :extension_ranges

  resources :phones, :except => [:new, :delete]

  resources :sub_departments

  resources :departments

  resources :categories

  resources :roles
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

  match 'phones/:id/free_extensions', :to => 'phones#free_extensions', :via => [:get, :post]
  match 'phones/:id/extension_list', :to => 'phones#extension_list', :via => [:get, :post]
  
  match 'sub_departments/:id/default_policies', :to => 'sub_departments#default_policies', :via => [:get]

  match 'search', :to => 'phones#search', :via => [:get, :post], :as => 'search'
  root :to => 'phones#index'
end
