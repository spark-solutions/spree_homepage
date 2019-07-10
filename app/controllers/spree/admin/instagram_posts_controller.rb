module Spree
  module Admin
    class InstagramPostsController < ResourceController
      include Spree::Backend::Callbacks

      before_action :instagram_settings, only: %i[index hashtag download]
      before_action :products, only: %i[index hashtag]
      before_action :instagram_users, only: %i[index hashtag]
      before_action :hashtag_param, only: %i[update_all download destroy_all]

      rescue_from Koala::Facebook::AuthenticationError, with: :facebook_error
      rescue_from Koala::Facebook::ClientError, with: :facebook_error

      def index
        @instagram_posts = Spree::InstagramPost.user.order(created_at: :desc)
      end

      def hashtag
        @instagram_posts = Spree::InstagramPost.hashtag.order(created_at: :desc)
      end

      def download
        if Instagram::LoadPosts.new(@instagram_settings, @hashtag).call
          flash[:success] = Spree.t(:instagram_posts_downloaded)
        else
          flash[:error] = Spree.t(:instagram_posts_downloaded_error)
        end
        redirect_to action: @hashtag ? :hashtag : :index
      end

      def update_all
        posts = params['instagram_post']
        Spree::InstagramPost.update(posts.keys, posts.values)
        redirect_to action: @hashtag ? :hashtag : :index
      end

      def destroy_all
        @hashtag ? Spree::InstagramPost.hashtag.destroy_all : Spree::InstagramPost.user.destroy_all
        redirect_to action: @hashtag ? :hashtag : :index
      end

      private

      def instagram_settings
        @instagram_settings ||= Spree::InstagramSetting.first_or_create
      end

      def products
        @products ||= Spree::Product.all
      end

      def instagram_users
        @instagram_users ||= Spree::InstagramUser.all
      end

      def hashtag_param
        @hashtag = params[:hashtag] == 'true'
      end

      def facebook_error(exception)
        flash[:error] = exception
        redirect_to action: @hashtag ? :hashtag : :index
      end
    end
  end
end
