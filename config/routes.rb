Trueleages::Application.routes.draw do
  root :to => "home#index"
  devise_for :accounts

  post "onboard/:account_id/resend_invitation" => "onboard#resend_invitation", :as => :resend_invitation
  get  "onboard/:account_id/*token" => "onboard#get_onboard_account", :as => :onboard_account
  post "onboard/:account_id/*token" => "onboard#onboard_account"

  get     "message_board/:target_type/:target_id/messages" => "message_board#index", :as => :message_board
  post    "message_board/:target_type/:target_id/messages" => "message_board#create"
  get     "message_board/:target_type/:target_id/messages/new" => "message_board#new", :as => :new_message_board_message
  get     "message_board/messages/:id"  => "message_board#show", :as => :message_board_message
  delete  "message_board/messages/:id"  => "message_board#destroy"


  get "teams/:id/members/new" => "team_members#new", :as => :new_team_member
  resources :team_members

  get "leagues/:league_id/teams" => "league_teams#index", :as => :league_teams
  post "leagues/:league_id/teams" => "league_teams#create"
  get "leagues/:league_id/teams/new" => "league_teams#new", :as => :new_league_team
  get "teams/:id" => "league_teams#show" , :as => :team
  put "teams/:id" => "league_teams#update"

  resources :locations

  get "leagues/:league_id/locations" => "league_locations#index", :as => :league_locations
  delete "leagues/:league_id/locations/:id" => "league_locations#destroy", :as => :league_location
  post "leagues/:league_id/locations" => "league_locations#create"
  get "leagues/:league_id/locations/:id" => "locations#show"

  get "leagues/:league_id/games" => "league_games#index", :as => :league_games
  delete "leagues/:league_id/games/:id" => "league_games#destroy", :as => :league_game
  put "leagues/:league_id/games/:id" => "league_games#update"
  post "leagues/:league_id/games" => "league_games#create"
  get "leagues/:league_id/games/new" => "league_games#new", :as => :new_league_game

  resources :leagues do
    get :schedule
    post :update_schedule
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
