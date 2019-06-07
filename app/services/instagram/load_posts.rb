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
        instagram_post = Spree::InstagramPost.find_by(instagram_id: post.id)
        if instagram_post
          instagram_post.update(data: post.to_json)
        else
          Spree::InstagramPost.create(instagram_id: post.id, data: post.to_json, instagram_setting_id: @settings_id, show: true)
        end
      end
    end
  end
end
