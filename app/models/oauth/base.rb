require 'oauth2'

module Oauth::Base
  def site
    host = @env["HTTP_X_FORWARDED_HOST"] || @env["HTTP_HOST"]
    @site ||= SS::Site.find_by_domain host
  end

  def node
    path = request.env["REQUEST_PATH"]
    @node ||= Member::Node::Login.site(site).in_path(path).sort(depth: -1).first
  end

  def client_id
    @client_id ||= begin
      Rails.logger.debug("fetch client id from #{node.try(:filename)} node")
      node.try("#{name}_client_id".downcase) || Rails.application.oauth.try("#{name}_client_id")
    end
  end

  def client_secret
    @client_secret ||= begin
      Rails.logger.debug("fetch client secret from #{node.try(:filename)} node")
      node.try("#{name}_client_secret".downcase) || Rails.application.oauth.try("#{name}_client_secret")
    end
  end

  # override OmniAuth::Strategies::OAuth2#client
  def client
    ::OAuth2::Client.new(client_id, client_secret, deep_symbolize(options.client_options))
  end
end
