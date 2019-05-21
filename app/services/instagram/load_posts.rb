module Instagram
  class LoadPosts
    attr_reader :feed, :settings_id

    def initialize(settings_id)
      @settings_id = settings_id
    end

    def call
      make_request
      create_records
    end

    private

    def make_request
      access_token = Spree::InstagramSetting.first.access_token
      client = Instagram.client(access_token: access_token)
      @feed = client.user_recent_media
    end

    def create_records
      @feed.each do |post|
        Spree::InstagramPost.find_or_create_by(instagram_id: post.id) do |instagram_post|
          instagram_post.data = post.to_json
          instagram_post.instagram_setting_id = @settings_id
          instagram_post.show = true
        end
      end
    end
  end
end
