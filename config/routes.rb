StrongSystem::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'main#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  match "index.php", :controller => 'main', :action => "index", :format => "php"
  match "about_us.php", :controller => 'main', :action => "about_us", :format => "php"
  match "services.php", :controller => 'main', :action => "services", :format => "php"
  match "projects.php", :controller => 'main', :action => "projects", :format => "php"
  match "recruitment.php", :controller => 'main', :action => "recruitment", :format => "php"
  match "contact.php", :controller => 'main', :action => "contact", :format => "php"
  match "spirit.php", :controller => 'main', :action => "spirit", :format => "php"
  match "introduction.php", :controller => 'main', :action => "introduction", :format => "php"
  match "culture.php", :controller => 'main', :action => "culture", :format => "php"
  match "organization.php", :controller => 'main', :action => "organization", :format => "php"
  match "honor.php", :controller => 'main', :action => "honor", :format => "php"
  match "ceo.php", :controller => 'main', :action => "ceo", :format => "php"


  match "login.php", :controller => 'users', :action => "login"
  match "logout", :controller => 'users', :action => "logout"


  match "/admin" => "admin_main#index"
  match 'login' => 'users#login', :as => :login
  match 'logout' => 'users#logout', :as => :logout

  #resources :admin_main

  #namespace :admin do
  #  resources :projects do
  #    get :edit, :on => :collection
  #    get :list, :on => :collection
  #    get :update, :on => :collection
  #  end
  #  #resources :projects do
  #  #  collection do
  #  #    get :list
  #  #  end
  #  #end
  #end


  match ':controller(/:action(/:id))(.:format)'
end
