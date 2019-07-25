module Instagram
  class LoadPosts
    def initialize(instagram_settings, hashtag = false)
      @instagram_settings = instagram_settings
      @hashtag = hashtag && !instagram_settings.hashtag_id.empty?
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

    def fields
      default = "caption,comments_count,id,like_count,media_type,media_url,permalink"
      @hashtag ? default : "#{default},username,owner{profile_picture_url,username,name}"
    end

    def media_url
      url = @hashtag ? "#{@instagram_settings.hashtag_id}/top_media" : "#{@user_id}/media"
      "#{url}?fields=#{fields}&user_id=#{@user_id}&limit=50"
    end

    def create_records
      @feed.each do |post|
        resources = @hashtag ? Spree::InstagramPost.hashtag : Spree::InstagramPost.user
        instagram_post = resources.find_by(instagram_id: post["id"])
        if instagram_post
          instagram_post.update(data: post.to_json)
        else
          hashtag_id = @hashtag ? @instagram_settings.hashtag_id : nil
          if @hashtag || ["IMAGE", "VIDEO"].include?(post["media_type"])
            Spree::InstagramPost.create(
              instagram_id: post["id"],
              data: post.to_json,
              instagram_setting_id: @instagram_settings.id,
              hashtag_id: hashtag_id,
              show: false,
            )
          end
        end
      end
    end
  end
end
