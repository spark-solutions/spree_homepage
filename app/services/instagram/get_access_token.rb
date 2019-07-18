module Instagram
  class GetAccessToken
    def initialize(code, redirect_uri)
      @code = code
      @redirect_uri = redirect_uri
    end

    def call
      make_request
      set_access_token
      set_user_id
    end

    private

    def make_request
      app_id = Rails.application.credentials.facebook_app_id
      app_secret = Rails.application.credentials.facebook_app_secret
      oauth = Koala::Facebook::OAuth.new(app_id, app_secret, @redirect_uri)
      @access_token = oauth.get_access_token(@code)
    end

    def user_id
      graph = Koala::Facebook::API.new(@access_token)
      accounts = graph.get_object("me?fields=accounts{instagram_business_account,username}") { |data| data["accounts"] }
      page = accounts["data"].find { |account| account["username"] == ENV["FB_PAGE_USERNAME"] } || accounts["data"].first
      page && page["instagram_business_account"] ? page["instagram_business_account"]["id"] : ""
    end

    def set_user_id
      Spree::InstagramSetting.user_id = user_id
    end

    def set_access_token
      Spree::InstagramSetting.access_token = @access_token
    end
  end
end
