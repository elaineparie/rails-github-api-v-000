class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id'=> ENV['GITHUB_CLIENT_ID'], 'client_secret' => ENV['GITHUB_CLIENT_SECRET'], 'code'=> params[:code] }
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.headers['Accept'] = 'application/json'
    end
      body = JSON.parse(resp.body)
      session[:token] = body["access_token"]
      redirect_to root_path
  end
end
