Spree::Api::ProductsController.class_eval do
  skip_before_filter :check_for_user_or_api_key, only: [:index, :show]
  skip_before_filter :authenticate_user, only: [:index, :show]
end
