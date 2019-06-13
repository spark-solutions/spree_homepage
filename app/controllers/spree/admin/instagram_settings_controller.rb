module Spree
  module Admin
    class InstagramSettingsController < Spree::Admin::BaseController
      before_action :instagram_setting, only: :update

      def update
        @instagram_setting.update(instagram_setting_params)
        redirect_to admin_instagram_posts_path
      end

      def destroy
        if Spree::InstagramSetting.first.destroy
          flash[:success] = Spree.t(:instagram_disconnected)
        else
          flash[:error] = Spree.t(:failed_disconnected)
        end
        redirect_to admin_instagram_posts_path
      end

      private

      def instagram_setting_params
        params.require(:instagram_setting).permit(:hashtag)
      end

      def instagram_setting
        @instagram_setting ||= Spree::InstagramSetting.first_or_create
      end
    end
  end
end
