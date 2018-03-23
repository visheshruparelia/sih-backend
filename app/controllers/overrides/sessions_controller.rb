class Overrides::SessionsController < DeviseTokenAuth::SessionsController
  def render_create_success
    @user = JSON.parse(@resource.to_json)
    @user["role"] = @resource.roles.first.name
    @user.to_json
    render json: @user
  end
end
