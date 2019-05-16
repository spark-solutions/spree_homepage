module Spree
  module Admin
    class InstagramPostsController < Spree::Admin::BaseController
      include Spree::Backend::Callbacks

      before_action :load_resource, only: [:index]

      def index; end

      def download
        Instagram::LoadPosts.new(@instagram_settings.id).call
        redirect_to action: :index
      end

      def update_visibility
        params['instagram_post'].keys.each do |id|
          post = Spree::InstagramPost.find(id.to_i)
          post.update(show: params['instagram_post'][id]['show'])
        end
        redirect_to action: :index
      end

      private

      attr_reader :resource

      def load_resource
        @instagram_posts ||= Spree::InstagramPost.order(created_at: :desc)
        @instagram_settings ||= Spree::InstagramSetting.first
      end
    end
  end
end
