module Spree
  module Admin
    class InstagramPostsController < Spree::Admin::BaseController
      include Spree::Backend::Callbacks

      before_action :load_resource, only: %i[index download]
      before_action :products, only: :index

      def index; end

      def download
        if Instagram::LoadPosts.new(@instagram_settings).call
          flash[:success] = Spree.t(:instagram_posts_downloaded)
        else
          flash[:error] = Spree.t(:instagram_posts_downloaded_error)
        end
        redirect_to action: :index
      end

      def update_all
        posts = params['instagram_post']
        Spree::InstagramPost.update(posts.keys, posts.values)
        redirect_to action: :index
      end

      private

      def load_resource
        @instagram_posts ||= Spree::InstagramPost.order(created_at: :desc)
        @instagram_settings ||= Spree::InstagramSetting.first_or_create
      end

      def products
        @products ||= Spree::Product.all
      end
    end
  end
end
