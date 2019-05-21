module Spree
  module Admin
    class InstagramSettingsController < Spree::Admin::BaseController
      include Spree::Backend::Callbacks

      def destroy
        if Spree::InstagramSetting.first.destroy
          flash[:success] = Spree.t(:instagram_disconnected)
        else
          flash[:error] = Spree.t(:failed_disconnected)
        end
        redirect_to admin_instagram_posts_path
      end
    end
  end
end
