module Instagram
  class GetAccessToken
    attr_reader :code, :redirect_uri, :response

    def initialize(code, redirect_uri)
      @code = code
      @redirect_uri = redirect_uri
    end

    def call
      make_request
      set_access_token
      set_code
    end

    private

    def make_request
      @response = Instagram.get_access_token(code, redirect_uri: redirect_uri)
    end

    def set_code
      Spree::InstagramSetting.set_code(code)
    end

    def set_access_token
      Spree::InstagramSetting.set_access_token(response.access_token)
    end
  end
end
