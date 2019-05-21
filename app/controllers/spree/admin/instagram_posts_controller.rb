module Spree
  module Admin
    class InstagramPostsController < Spree::Admin::BaseController
      include Spree::Backend::Callbacks

      before_action :load_resource, only: %i[index download]

      def index; end

      def download
        if Instagram::LoadPosts.new(@instagram_settings.id).call
          flash[:success] = Spree.t(:instagram_posts_downloaded)
        else
          flash[:error] = Spree.t(:instagram_posts_downloaded_error)
        end
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

      def load_resource
        @instagram_posts ||= Spree::InstagramPost.order(created_at: :desc)
        @instagram_settings ||= Spree::InstagramSetting.first_or_create
      end
    end
  end
end
