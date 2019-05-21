module Spree
  module Admin
    class InstagramCallbacksController < Spree::Admin::BaseController
      include Spree::Backend::Callbacks

      def connect
        redirect_to Instagram.authorize_url(redirect_uri: admin_instagram_callbacks_callback_url, scope: 'public_content')
      end

      def callback
        if Instagram::GetAccessToken.new(params[:code], admin_instagram_callbacks_callback_url).call
          flash[:success] = Spree.t(:instagram_connected)
        else
          flash[:error] = Spree.t(:failed, resource: Spree.t(:instagram_callback))
        end

        redirect_to admin_instagram_posts_path
      end
    end
  end
end
