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

    def update_instagram_media(saved_media_model, saved_media_url, new_media_url)
      return if new_media_url == nil || new_media_url.empty?

      if !saved_media_model.attached? || saved_media_url != new_media_url
        saved_media_model.purge
        download_stream = open(new_media_url)
        basename = File.basename(download_stream.base_uri.path)
        saved_media_model.attach(io: download_stream, filename: basename)
      end
    end

    def create_or_update_records
      @feed.each do |post|
        resources = @hashtag ? Spree::InstagramPost.hashtag : Spree::InstagramPost.user
        saved_instagram_post = resources.find_by(instagram_id: post["id"])
        media_url = post["media_url"]

        if saved_instagram_post
          saved_instagram_post_data = JSON.parse(saved_instagram_post["data"])

          update_instagram_media(saved_instagram_post.media, saved_instagram_post_data["media_url"], media_url)

          if !@hashtag
            profile_picture_media_url = post["owner"]["profile_picture_url"]
            update_instagram_media(
              saved_instagram_post.profile_picture_media,
              saved_instagram_post_data["owner"]["profile_picture_url"],
              profile_picture_media_url
            )
          end

          saved_instagram_post.update(
            data: post.to_json,
            show: (
              saved_instagram_post["show"] &&
              media_url.present? &&
              profile_picture_media_url.present?
            )
          )
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

            update_instagram_media(saved_instagram_post.media, nil, media_url)

            if !@hashtag
              profile_picture_media_url = post["owner"]["profile_picture_url"]
              update_instagram_media(saved_instagram_post.profile_picture_media, nil, profile_picture_media_url)
            end
          end
        end
      end
    end
  end
end
