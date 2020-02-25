module Instagram
  class LoadPosts
    def initialize(instagram_settings, hashtag = false)
      @instagram_settings = instagram_settings
      @hashtag = hashtag && !instagram_settings.hashtag_id.empty?
    end

    def call
      setup_api
      make_request
      create_or_update_records
    end

    private

    def setup_api
      @graph_api = Koala::Facebook::API.new(@instagram_settings.access_token)
      @user_id = @instagram_settings.user_id
    end

    def make_request
      @feed = @graph_api.get_object(instagram_media_url)
    end

    def fields
      default = "caption,comments_count,id,like_count,media_type,media_url,permalink"
      @hashtag ? default : "#{default},username,owner{profile_picture_url,username,name}"
    end

    def instagram_media_url
      url = @hashtag ? "#{@instagram_settings.hashtag_id}/top_media" : "#{@user_id}/media"
      "#{url}?fields=#{fields}&user_id=#{@user_id}&limit=50"
    end

    def create_or_update_records
      @feed.each do |post|
        resources = @hashtag ? Spree::InstagramPost.hashtag : Spree::InstagramPost.user
        saved_instagram_post = resources.find_by(instagram_id: post["id"])
        media_url = post["media_url"]

        if saved_instagram_post
          saved_instagram_post_media_url = JSON.parse(saved_instagram_post["data"])["media_url"]

          if media_url.present? && (media_url != saved_instagram_post_media_url || !saved_instagram_post.media.attached?)
            saved_instagram_post.media.purge
            download_stream = open(media_url)
            basename = File.basename(download_stream.base_uri.path)
            saved_instagram_post.media.attach(io: download_stream, filename: basename)
          end

          saved_instagram_post.update(data: post.to_json, show: saved_instagram_post["show"] && media_url.present?)
        else
          hashtag_id = @hashtag ? @instagram_settings.hashtag_id : nil

          if !@hashtag || ["IMAGE", "VIDEO"].include?(post["media_type"])
            saved_instagram_post = Spree::InstagramPost.create(
              instagram_id: post["id"],
              data: post.to_json,
              instagram_setting_id: @instagram_settings.id,
              hashtag_id: hashtag_id,
              show: false
            )

            if media_url.present?
              download_stream = open(media_url)
              basename = File.basename(download_stream.base_uri.path) 
              saved_instagram_post.media.attach(io: download_stream, filename: basename)
            end
          end
        end
      end
    end
  end
end
