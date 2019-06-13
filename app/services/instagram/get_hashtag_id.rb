module Instagram
  class GetHashtagId
    def initialize(instagram_settings, hashtag)
      @instagram_settings = instagram_settings
      @hashtag = hashtag
    end

    def call
      make_request
    end

    private

    def make_request
      graph_api = Koala::Facebook::API.new(@instagram_settings.access_token)
      user_id = @instagram_settings.user_id
      response = graph_api.get_object("ig_hashtag_search?user_id=#{user_id}&q=#{@hashtag}")
      response.first['id']
    end
  end
end
