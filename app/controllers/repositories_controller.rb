class RepositoriesController < ApplicationController

  def index
  end

  def create
  resp = Faraday.post("https://api.github.com/repos") do |req|
    req.params['oauth_token'] = session[:token]
    req.params['name'] = params[:name]
  end

  redirect_to repositories_path
end

end
