module Instagram
  class GetLoginUrl
    def initialize(redirect_uri, permissions = 'instagram_basic pages_show_list')
      @redirect_uri = redirect_uri
      @permissions = permissions
    end

    def call
      login_url
    end

    private

    def login_url
      app_id = Rails.application.credentials.facebook_app_id
      app_secret = Rails.application.credentials.facebook_app_secret
      oauth = Koala::Facebook::OAuth.new(app_id, app_secret, @redirect_uri)
      oauth.url_for_oauth_code(permissions: @permissions)
    end
  end
end
