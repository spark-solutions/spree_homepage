namespace :spree_homepage do
  desc "Load Instagram posts from FB Graph API"
  task load_posts: :environment do
    instagram_settings = Spree::InstagramSetting.first
    Instagram::LoadPosts.new(instagram_settings, true).call # hashtag
    Instagram::LoadPosts.new(instagram_settings, false).call # user
  end
end
