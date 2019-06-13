module Instagram
  class LoadPosts
    def initialize(instagram_settings)
      @instagram_settings = instagram_settings
    end

    def call
      setup_api
      make_request
      create_records
    end

    private

    def setup_api
      @graph_api = Koala::Facebook::API.new(@instagram_settings.access_token)
      @user_id = @instagram_settings.user_id
    end

    def make_request
      @feed = @graph_api.get_object(media_url)
    end

    def fields(hashtag_id)
      default = 'caption,comments_count,id,like_count,media_type,media_url,permalink'
      hashtag_id.empty? ? "#{default},username" : default
    end

    def media_url
      hashtag_id = @instagram_settings.hashtag_id
      url = hashtag_id.empty? ? "#{@user_id}/media" : "#{hashtag_id}/top_media"
      "#{url}?fields=#{fields(hashtag_id)}&user_id=#{@user_id}&limit=50"
    end

    def create_records
      @feed.each do |post|
        instagram_post = Spree::InstagramPost.find_by(instagram_id: post['id'])
        if instagram_post
          instagram_post.update(data: post.to_json)
        else
          Spree::InstagramPost.create(instagram_id: post['id'], data: post.to_json, instagram_setting_id: @instagram_settings.id, show: true)
        end
      end
    end
  end
end
