module Spree
  module Admin
    class InstagramSettingsController < Spree::Admin::BaseController
      include Spree::Backend::Callbacks

      before_action :load_resource, only: %i[edit update destroy]

      def edit
      end

      def update
        if resource.update(instagram_setting_params)
          flash[:success] = Spree.t(:success_updeate, resource: Spree.t(:instagram_settiongs))
        else
          flash[:error] = Spree.t(:failed_update, resource: Spree.t(:instagram_settiongs))
        end

        render :edit
      end

      def destroy
        if resource.destroy
          flash[:success] = Spree.t(:success_destroy, resource: Spree.t(:instagram_settiongs))
        else
          flash[:error] = Spree.t(:failed_destroy, resource: Spree.t(:instagram_settiongs))
        end

        redirect_to edit_admin_instagram_settings_path
      end

      private

      attr_reader :resource

      def load_resource
        @resource ||= Spree::InstagramSetting.first_or_create
      end

      def instagram_setting_params
        params.require(:instagram_setting).permit(%i[access_token target_account])
      end
    end
  end
end
