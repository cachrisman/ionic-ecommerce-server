Rails.application.routes.draw do
  devise_scope :spree_user do
    post "api/login", to: "spree/user_sessions#create_api_login", constraints: { format: 'json' }
  end
  mount Spree::Core::Engine, :at => '/'

end
