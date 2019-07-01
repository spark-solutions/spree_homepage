module Spree
  module Admin
    class InstagramCallbacksController < Spree::Admin::BaseController
      include Spree::Backend::Callbacks

      def connect
        redirect_to Instagram::GetLoginUrl.new(admin_instagram_callbacks_callback_url).call
      end

      def callback
        if params[:code] && Instagram::GetAccessToken.new(params[:code], admin_instagram_callbacks_callback_url).call
          flash[:success] = Spree.t(:instagram_connected)
        else
          flash[:error] = params[:error_message]
        end

        redirect_to admin_instagram_posts_path
      end
    end
  end
end
