Spree::UserSessionsController.class_eval do
  skip_before_action :verify_authenticity_token, only: :create_api_login
  respond_to :json

  def create_api_login
    email = params[:email]
    password = params[:password]
    if request.format != :json
      render json: { error: "The request must be json"}, status: 406 and return
    end
    if email.nil? or password.nil?
      render json: { error: "The request must contain the user email and password."}, status: 400 and return
    end

    @user=Spree::User.find_by_email(email.downcase)

    if @user.nil?
      logger.info("User #{email} failed signin, user cannot be found.")
      render  json: { error: "Invalid email or password."}, status: 401 and return
    end

    unless @user.valid_password?(password)
      logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
      render json: { error: t('devise.failure.invalid') }, status: :unprocessable_entity
    else
      render json: { token: @user.spree_api_key}, status: 200
    end
  end
end
