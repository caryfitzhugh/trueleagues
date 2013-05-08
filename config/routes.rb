Trueleages::Application.routes.draw do
  root :to => "home#index"
  devise_for :accounts

  post "onboard/:account_id/resend_invitation" => "onboard#resend_invitation", :as => :resend_invitation
  get  "onboard/:account_id/*token" => "onboard#get_onboard_account", :as => :onboard_account
  post "onboard/:account_id/*token" => "onboard#onboard_account"

  resources :teams

  resources :locations

  scope :shallow_path => "messages" do
    resources :message_boards do
      #resources :message_board_messages, :shallow => false, :only   => [:index, :create, :new]
      resources :message_board_messages, :shallow => true
    end
  end

  get "teams/:id/members/new" => "team_members#new", :as => :new_team_member
  resources :team_members

  get "leagues/:id/teams" => "teams#index", :as => :league_teams
  post "leagues/:id/teams" => "teams#create"
  get "leagues/:id/teams/new" => "teams#new", :as => :new_league_team

  resources :leagues do
  end

  post "mail/incoming" => "incoming_mail#ingest"
  get  "mail"          => "incoming_mail#index"

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
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
